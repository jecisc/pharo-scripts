#!/usr/bin/env python3
"""Print the next free backlog ID, scanning active lists and all archive files.

Usage:
  python3 next-id.py A        -> next agent finding ID, e.g. A-013
  python3 next-id.py U        -> next user backlog ID, e.g. U-032
  python3 next-id.py --check  -> list duplicated IDs (should print nothing)
"""
import collections
import pathlib
import re
import sys

BACKLOG = pathlib.Path(__file__).resolve().parent
FILES = [BACKLOG / "agent-findings.md", BACKLOG / "user-backlog.md",
         *sorted((BACKLOG / "archive").glob("*.md"))]
HEADING = re.compile(r"^## ([AU])-(\d+) ", re.M)


def all_ids():
    ids = []
    for f in FILES:
        if f.exists():
            ids += [(m.group(1), int(m.group(2))) for m in HEADING.finditer(f.read_text())]
    return ids


def main():
    args = sys.argv[1:]
    if args == ["--check"]:
        counts = collections.Counter(f"{p}-{n:03d}" for p, n in all_ids())
        for k, v in sorted(counts.items()):
            if v > 1:
                print(f"duplicate {k} x{v}")
        return
    if len(args) != 1 or args[0] not in ("A", "U"):
        sys.exit(__doc__)
    prefix = args[0]
    nums = [n for p, n in all_ids() if p == prefix]
    print(f"{prefix}-{(max(nums) if nums else 0) + 1:03d}")


if __name__ == "__main__":
    main()
