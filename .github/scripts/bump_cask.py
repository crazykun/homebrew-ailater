#!/usr/bin/env python3
"""Bump a Homebrew cask to a new upstream release.

Usage: bump_cask.py <cask.rb> <old_ver> <new_ver> <asset_name> <sha256_hex>

- Replaces the version string (exactly once).
- Rewrites the sha256 line (exactly once; a trailing comment is preserved).
- Validates <asset_name> against the cask's own url template
  (`.../releases/download/v#{version}/<template>` with #{version} → new_ver),
  so a digest fetched for a mismatched asset can never land in the file.
- Unlike bump_formula.py, the url line is a #{version} template and never
  changes; only version and sha256 are touched.
- Fails without modifying the file if any invariant is violated.
"""
import re
import sys

cask_path, old, new, asset, sha = sys.argv[1:6]

if not re.fullmatch(r"[0-9a-f]{64}", sha):
    sys.exit(f"ERROR: {sha!r} is not a sha256 hex digest")

src = open(cask_path).read()

# url 模板里推算出的资产名必须与 yml 侧查 digest 用的名字一致
template = re.search(
    r'url "https://github\.com/[^/]+/[^/]+/releases/download/v#\{version\}/([^"]+)"',
    src,
)
if not template:
    sys.exit("ERROR: no #{version} asset url template found in cask")
expected = template.group(1).replace("#{version}", new)
if expected != asset:
    sys.exit(f"ERROR: url template yields {expected!r}, digest was fetched for {asset!r}")

src, n_ver = re.subn(rf'version "{re.escape(old)}"', f'version "{new}"', src)
if n_ver != 1:
    sys.exit(f"ERROR: version \"{old}\" found {n_ver} times, expected exactly 1")

src, n_sha = re.subn(r'sha256 "[0-9a-f]{64}"', f'sha256 "{sha}"', src)
if n_sha != 1:
    sys.exit(f"ERROR: sha256 line found {n_sha} times, expected exactly 1")

open(cask_path, "w").write(src)
print(f"version {old} -> {new}, sha256 -> {sha[:12]}…, asset {asset}")
