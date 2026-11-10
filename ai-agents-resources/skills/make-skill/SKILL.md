---
name: make-skill
description: Create a new personal skill in ~/Library/Preferences/pharo/ai-agents-resources/skills and link it so both Claude Code and opencode can use it. Use when the user asks to create, add, or write a new skill, or to make a reusable instruction set for their agents.
---

# Make a personal skill

A skill is a folder containing a `SKILL.md` file. The file starts with frontmatter:

```
---
name: my-skill-name          # lowercase, hyphens, must match the folder name
description: What it does and WHEN to use it. The agent uses this to decide whether to load the skill, so name the triggers.
---
```

Below the frontmatter, write the instructions as plain Markdown: steps, rules, commands, and examples.

## Steps

1. Pick a short lowercase name, e.g. `release-notes`.
2. Create `~/Library/Preferences/pharo/ai-agents-resources/skills/<name>/SKILL.md` with the frontmatter and instructions.
3. Keep it short. Put long reference material in other files in the same folder and mention them from `SKILL.md`.
4. Run `~/Library/Preferences/pharo/ai-agents-resources/scripts/link-skills.sh`. This creates symlinks in `~/.claude/skills/` and `~/.config/opencode/skills/`.
5. Restart the session. Claude Code and opencode read skills at startup, so a new skill may not appear until then.

## Rules

- Never create a skill that duplicates an existing Anthropic or plugin skill. Check the list first.
- Never put secrets (API keys, tokens) in a skill. Those belong in environment variables.
- Do not commit to git unless the user asks.
