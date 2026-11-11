# Backlogs

Two cross-session lists. Both live here and are read by every agent session (Claude Code and opencode) through `AGENTS.md`.

| File | Owner | Purpose |
|---|---|---|
| `agent-findings.md` | Agents log, you triage | Every bug, difficulty, friction, or improvement an agent hits, including ones it worked around. Nothing is silently dropped. |
| `user-backlog.md` | You | Things you want to work on. Agents only edit it when you ask. |

## Entry format

Use the same fields in both files:

- **Status:** open | in-progress | done | wontfix
- **Area:** the repo, dependency, or tool involved
- **Type:** bug | friction | improvement | dependency | security | doc (missing or outdated documentation)
- **Found:** date and agent (Claude Code or opencode)
- **Summary:** one or two sentences
- **Evidence:** file path, command, or exact error text
- **Upstream:** yes | no | unknown. Yes means the fix belongs in a project you contribute to.
- **Next step:** what would resolve it

IDs: `A-001`, `A-002`, ... for agent findings; `U-001`, ... for your backlog. Never reuse an ID.

To get a new ID, run `python3 backlog/next-id.py A` (or `U`). It scans the active lists and every archive file, so IDs stay unique across sessions. Check for duplicates with `python3 backlog/next-id.py --check`.

## Archive

When an entry's **Status** becomes `done` or `wontfix`, run `python3 backlog/archive-resolved.py`. It moves the entry out of the active list into `archive/YYYY-Wnn.md`, one file per ISO week, named by the **Resolved** date. It adds **Resolved** (today's date) if the entry lacks one. Running it again is safe.
