#!/usr/bin/env python3
"""Move resolved backlog entries (Status: done or wontfix) into weekly archive files.

Archive file: backlog/archive/YYYY-Wnn.md, named by the ISO week of the resolution date.
An entry without a **Resolved:** line gets today's date, recorded in the entry.
Safe to run repeatedly.
"""
import datetime
import pathlib
import re

BACKLOG = pathlib.Path(__file__).resolve().parent
ARCHIVE = BACKLOG / "archive"
SOURCES = ["agent-findings.md", "user-backlog.md"]
RESOLVED_STATUSES = {"done", "wontfix"}
ENTRY_START = re.compile(r"^## [A-Z]+-\d+ ", re.M)
STATUS = re.compile(r"^- \*\*Status:\*\* (\S+)", re.M)
RESOLVED = re.compile(r"^- \*\*Resolved:\*\* (\d{4}-\d{2}-\d{2})", re.M)


def split_entries(text):
    """Return (header, [entry_text, ...]) where each entry starts at '## ID ...'."""
    starts = [m.start() for m in ENTRY_START.finditer(text)]
    if not starts:
        return text, []
    header = text[: starts[0]]
    entries = []
    for i, s in enumerate(starts):
        end = starts[i + 1] if i + 1 < len(starts) else len(text)
        entries.append(text[s:end].rstrip() + "\n")
    return header, entries


def with_resolved_date(entry, today):
    if RESOLVED.search(entry):
        return entry
    return STATUS.sub(lambda m: m.group(0) + f"\n- **Resolved:** {today}", entry, count=1)


def archive_file_for(date):
    year, week, _ = date.isocalendar()
    monday = date - datetime.timedelta(days=date.weekday())
    return ARCHIVE / f"{year}-W{week:02d}.md", f"# Archive {year}-W{week:02d} (week of {monday.isoformat()})\n\n---\n\n"


def main():
    today = datetime.date.today()
    moved = 0
    for name in SOURCES:
        path = BACKLOG / name
        if not path.exists():
            continue
        header, entries = split_entries(path.read_text())
        keep = []
        for entry in entries:
            m = STATUS.search(entry)
            if not m or m.group(1) not in RESOLVED_STATUSES:
                keep.append(entry)
                continue
            entry = with_resolved_date(entry, today.isoformat())
            resolved = datetime.date.fromisoformat(RESOLVED.search(entry).group(1))
            target, new_header = archive_file_for(resolved)
            ARCHIVE.mkdir(exist_ok=True)
            if not target.exists():
                target.write_text(new_header)
            with target.open("a") as f:
                f.write(entry + "\n")
            print(f"archived {entry.splitlines()[0][3:].split(' — ')[0]} -> {target.relative_to(BACKLOG)}")
            moved += 1
        if moved:
            path.write_text(header + "\n".join(keep))
    print(f"done: {moved} entr{'y' if moved == 1 else 'ies'} archived")


if __name__ == "__main__":
    main()
