# AI agents resources

Everything that customises the AI coding agents on this machine: Claude Code and opencode. It lives inside the pharo repo and is tracked by it. Live backlog data is the exception (see `backlog/`).

To set up a new machine, run `./setup.sh` from this folder. It checks prerequisites, creates links, and reports the manual steps.

## Contents

| Path | What it is |
|---|---|
| `AGENTS.md` | Instructions read by both agents at the start of each session. Claude Code reads it through `~/.claude/CLAUDE.md`, and opencode through the `instructions` entry in its config. Holds the Pharo rules, the backlog rules, and the rule to keep `setup.sh` up to date. |
| `setup.sh` | Bootstrap script for a new machine. Safe to re-run. Never overwrites a real file; it warns instead. |
| `skills/` | Your personal skills. Each folder holds one `SKILL.md`. Linked into `~/.claude/skills/` and `~/.config/opencode/skills/`. |
| `skills/make-skill/` | Skill that explains how to create a new personal skill. |
| `scripts/link-skills.sh` | Creates the skill symlinks. Run it after adding a skill. |
| `claude/statusline-command.sh` | Status line script (git branch, context, rate limits, model). Symlinked into `~/.claude/`. |
| `claude/task-list/` | Source of the task-list plugin: the Tasks side pane and the `set_tasks` tool. The Claude Code marketplace `cyril-mods` points here. |
| `claude/templates/` | Templates for `~/.claude/settings.json` and `~/.claude/CLAUDE.md`. Placeholders `{{HOME}}` and `{{REPO}}` are filled in by `setup.sh`. |
| `opencode/opencode.template.jsonc` | Template for the opencode config, with the API key replaced by `REPLACE_WITH_YOUR_KEY`. |
| `backlog/` | Two cross-session lists plus their tools. See below. |

## Backlog

The `backlog/` folder holds:
- `agent-findings.md`: problems the agents hit, logged by the agents (`A-` IDs).
- `user-backlog.md`: things you want to work on, updated when you ask (`U-` IDs).
- `archive/`: resolved entries, one file per ISO week.
- `archive-resolved.py`: moves entries marked `done` or `wontfix` into `archive/`.
- `next-id.py`: prints the next free ID and checks for duplicates.
- `README.md`: the entry format and the rules.

The two lists and `archive/` are listed in `backlog/.gitignore`, so git does not track them. The scripts and templates are tracked. A new machine starts with empty lists.

## Keeping it current

When you add or change a skill, plugin, marketplace entry, tool dependency, or agent config, update `setup.sh` and the templates in the same change. The rule is in `AGENTS.md`.

Never put secrets in tracked files. Use `REPLACE_WITH_YOUR_KEY` placeholders.
