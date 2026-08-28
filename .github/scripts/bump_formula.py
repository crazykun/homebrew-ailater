#!/usr/bin/env python3
"""Bump a Homebrew formula to a new upstream release.

Usage: bump_formula.py <formula.rb> <upstream> <old_ver> <new_ver> <assets_list>

- Replaces the version string.
- Finds every `url "https://github.com/<upstream>/releases/download/v<old>/<file>"`
  and rewrites it (and the sha256 on the following line) to the new release.
- Asset names that embed the version (e.g. `foo-v1.2.3-x86_64.tar.gz`) are
  handled by substituting the old version substring with the new one.
- Fails without modifying the file if any expected asset is missing from the
  new release.
"""
import hashlib
import re
import sys
import urllib.request

formula, upstream, old, new, assets_file = sys.argv[1:6]
with open(assets_file) as f:
    assets = set(line.strip() for line in f if line.strip())

url_re = re.compile(
    rf'url "https://github\.com/{re.escape(upstream)}/releases/download/v{re.escape(old)}/([^"]+)"\n(\s+)sha256 "[0-9a-f]+"'
)

old_names = [m.group(1) for m in url_re.finditer(open(formula).read())]
if not old_names:
    sys.exit(f"ERROR: no v{old} asset urls found in {formula}")

# 预校验：所有推算出的新资产必须存在于新 Release，缺一个整体放弃
new_names = [n.replace(f"v{old}", f"v{new}").replace(old, new) for n in old_names]
for name in new_names:
    if name not in assets:
        sys.exit(f"ERROR: asset {name!r} not found in {upstream} v{new} release; aborting")


def fetch_sha256(url, tries=3):
    for i in range(tries):
        try:
            with urllib.request.urlopen(url, timeout=120) as r:
                return hashlib.sha256(r.read()).hexdigest()
        except Exception as e:
            if i == tries - 1:
                raise
            print(f"retry {i + 1}/{tries - 1} after error: {e}")


def repl(m):
    indent = m.group(2)
    name = m.group(1).replace(f"v{old}", f"v{new}").replace(old, new)
    url = f"https://github.com/{upstream}/releases/download/v{new}/{name}"
    sha = fetch_sha256(url)
    print(f"{name}  {sha}")
    return f'url "{url}"\n{indent}sha256 "{sha}"'


src = open(formula).read()
src = url_re.sub(repl, src)
src = src.replace(f'version "{old}"', f'version "{new}"', 1)
open(formula, "w").write(src)
print(f"OK: {formula} {old} -> {new}")
