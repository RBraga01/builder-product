#!/usr/bin/env python3
"""Verify version numbers are consistent across README, CHANGELOG, and CLAUDE.md."""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).parent.parent
LABEL = "builder-product"

files = {
    "README.md":   (ROOT / "README.md",   rf"{re.escape(LABEL)}[^\n]*v(\d+\.\d+\.\d+)"),
    "CHANGELOG.md":(ROOT / "CHANGELOG.md", r"^## (\d+\.\d+\.\d+)"),
    "CLAUDE.md":   (ROOT / "CLAUDE.md",   rf"{re.escape(LABEL)}[^\n]*v(\d+\.\d+\.\d+)"),
}

versions = {}
errors = []

for name, (path, pattern) in files.items():
    if not path.exists():
        errors.append(f"MISSING: {name}")
        continue
    text = path.read_text(encoding="utf-8")
    match = re.search(pattern, text, re.MULTILINE)
    if not match:
        errors.append(f"NO VERSION FOUND: {name}")
    else:
        versions[name] = match.group(1)

if errors:
    for e in errors:
        print(f"ERROR: {e}")
    sys.exit(1)

unique = set(versions.values())
if len(unique) != 1:
    print("VERSION MISMATCH:")
    for f, v in versions.items():
        print(f"  {f}: {v}")
    sys.exit(1)

print(f"OK: all files agree on version {next(iter(unique))}")
