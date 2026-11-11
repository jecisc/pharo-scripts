# Backlogs

Two cross-session lists. Both live here and are read by every agent session (Claude Code and opencode) through `AGENTS.md`, which points to this file.

| File | Owner | Purpose |
|---|---|---|
| `agent-findings.md` | Agents log, you triage | Every bug, difficulty, friction, improvement or documentation gap an agent hits, including ones it worked around. Nothing is silently dropped. |
| `user-backlog.md` | You | Things you want to work on. Agents only edit it when you ask. |

## Rules for agents

- Read `user-backlog.md` at the start of a session to know what the user wants to work on. Edit it **only when the user asks you to**.
- **Log every problem you hit** in `agent-findings.md`: bugs, errors, workarounds, friction, things that would make future work simpler, and suspected security issues. Log it even if you worked around it. Do not silently ignore a problem.
- **Log improvements, not only problems.** When you see a way to make a tool, MCP server, skill, plugin or project better, log it as `Type: improvement` even if nothing broke. The Pharo MCP (`pharo` server, its `tool_*`, `method_*`, `class_*`, `test_run` and `image_evaluate` tools) is in scope: an unclear tool description, a missing parameter, a slow or noisy result, an error that does not say what to do next.
- **Log missing or outdated documentation** as `Type: doc`: a project, tool or skill lacks docs for something you needed, or its docs contradict the code or the current behaviour. Name the project in **Area** and the file or missing topic in **Evidence**.
- **Be precise.** **Area** names the exact project, tool, server or file (`pharo` MCP, `tool_search`, `Evref-BL/Pharo-Tree-Sitter`), not a category. **Evidence** holds the command, the exact error text or the file and line. **Summary** says what is wrong or what would be better, in one or two sentences, without speculation about the cause unless you verified it.
- Mention in your reply to the user when you add a finding. Give its ID.
- **Tags, Priority and Difficulty.** When you add an entry and the context tells you a value (the project, the tool, how urgent the user made it, how much work it looks like), fill the field and list it in **Guessed:**. Then ask the user in your reply whether each guess is right. When the user confirms, remove the **Guessed:** line; when they correct a value, change it and remove the line. Leave a field out when the context gives no basis for it.
- Most dependencies, including Pharo itself, are projects the user contributes to. Set **Upstream** to `yes` when a fix belongs there.
- Get new IDs with `python3 backlog/next-id.py A` (or `U`) right before writing an entry. Never reuse an ID. Update a finding's **Status** when you resolve it, instead of deleting it.
- When you set a finding or backlog item to `done` or `wontfix`, add a **Resolved:** date and run `python3 backlog/archive-resolved.py` (under `ai-agents-resources/`). This moves it to the weekly file in `backlog/archive/`.

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
- **Tags:** comma-separated subjects, such as `Pharo`, `Perso`, `Moose`, `MCP`, `Iceberg`. Reuse an existing tag before inventing one. Optional.
- **Priority:** high | medium | low. Optional.
- **Difficulty:** easy | medium | hard, your estimate of the effort. Optional.
- **Guessed:** lists the fields above that an agent inferred from context and the user has not confirmed yet, such as `Tags, Priority`. Removed once the user confirms or corrects them. Absent when every field was given or confirmed.

IDs: `A-001`, `A-002`, ... for agent findings; `U-001`, ... for your backlog. Never reuse an ID.

To get a new ID, run `python3 backlog/next-id.py A` (or `U`). It scans the active lists and every archive file, so IDs stay unique across sessions. Check for duplicates with `python3 backlog/next-id.py --check`.

## Archive

When an entry's **Status** becomes `done` or `wontfix`, run `python3 backlog/archive-resolved.py`. It moves the entry out of the active list into `archive/YYYY-Wnn.md`, one file per ISO week, named by the **Resolved** date. It adds **Resolved** (today's date) if the entry lacks one. Running it again is safe.
