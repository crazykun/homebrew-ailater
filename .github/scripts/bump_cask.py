#!/usr/bin/env python3
"""Bump a Homebrew cask to a new upstream release.

Usage:
  bump_cask.py <cask.rb> <old_ver> <new_ver> <asset_name> <sha256_hex>
  bump_cask.py <cask.rb> <old_ver> <new_ver> <url_template> "arm:<hex> intel:<hex>"

- Replaces the version string (exactly once).
- Rewrites the sha256 line (exactly once; a trailing comment is preserved).
- Single form validates <asset_name> against the cask's own url template
  (`.../releases/download/v#{version}/<template>` with #{version} → new_ver),
  so a digest fetched for a mismatched asset can never land in the file.
- Arch form (cask url 含 #{arch}、sha256 arm:/intel: 双行) takes the raw url
  template, digests keyed by arch (arm=aarch64, intel=x86_64), each written
  into its own line, layout preserved.
- Unlike bump_formula.py, the url line is a #{version} template and never
  changes; only version and sha256 are touched.
- Fails without modifying the file if any invariant is violated.
"""
import re
import sys

ARCH = {"arm": "aarch64", "intel": "x86_64"}

cask_path, old, new, asset, sha_arg = sys.argv[1:6]

src = open(cask_path).read()

# url 模板里推算出的资产名必须与 yml 侧查 digest 用的名字一致
template = re.search(
    r'url "https://github\.com/[^/]+/[^/]+/releases/download/v#\{version\}/([^"]+)"',
    src,
)
if not template:
    sys.exit("ERROR: no #{version} asset url template found in cask")
expected = template.group(1).replace("#{version}", new)

tokens = sha_arg.split()
if len(tokens) == 1 and re.fullmatch(r"[0-9a-f]{64}", sha_arg):
    if expected != asset:
        sys.exit(f"ERROR: url template yields {expected!r}, digest was fetched for {asset!r}")
    digests = [("", sha_arg)]
else:
    if "#{arch}" not in template.group(1):
        sys.exit("ERROR: arch digests given but cask url has no #{arch}")
    digests = []
    for tok in tokens:
        key, sep, val = tok.partition(":")
        if not sep or key not in ARCH or not re.fullmatch(r"[0-9a-f]{64}", val):
            sys.exit(f"ERROR: {tok!r} is not a valid digest token (arch:64-hex)")
        digests.append((key, val))

src, n_ver = re.subn(rf'version "{re.escape(old)}"', f'version "{new}"', src)
if n_ver != 1:
    sys.exit(f"ERROR: version \"{old}\" found {n_ver} times, expected exactly 1")

for key, sha in digests:
    if key:
        src, n_sha = re.subn(rf'{key}:(\s*)"[0-9a-f]{{64}}"', rf'{key}:\1"{sha}"', src)
    else:
        src, n_sha = re.subn(r'sha256 "[0-9a-f]{64}"', f'sha256 "{sha}"', src)
    if n_sha != 1:
        sys.exit(f"ERROR: sha256 line ({key or 'bare'}) found {n_sha} times, expected exactly 1")

open(cask_path, "w").write(src)
summary = ", ".join(f"{key or 'sha256'} -> {val[:12]}…" for key, val in digests)
print(f"version {old} -> {new}, {summary}")
