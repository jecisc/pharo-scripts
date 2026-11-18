---
name: clear-commit-messages
description: Write commit messages, PR titles and PR descriptions in the user's own terse style, matching how they wrote before agents. Use whenever the user asks to write, rewrite or review a commit message, a commit, a PR title or a PR description.
---

# Commit and PR messages in the user's style

The user's messages are short. Write the way they did before agents: a clear subject, a body only when it adds something, and no template.

## Commit subject

- Imperative, starting with a verb: "Fix", "Add", "Remove", "Clean", "Move", "Rename", "Manage", "Deprecate", "Declare".
- No trailing period.
- Name the exact class, method or package, with `>>` for methods: "Remove dead code in UIManager", "Rename ParseTreeRules", "Fix bug when adding an extension method overriding a trait method".
- Aim for about 45 characters. Keep it under 72.
- Say what the commit does, not what was wrong with the code. A one-word subject is fine for trivial changes: "Typo", "Fix tests", "Class comment".

## Commit body

- Skip the body when the subject says everything. This is the most common case.
- Add a body only when the reason is not obvious from the diff. Use one or two plain sentences, not a paragraph about the history.
- Length of the body follows the difficulty of the change. A simple change gets a short body, and a hard-to-explain change can take several sentences and bullets. Do not pad a simple change, and do not squeeze a complex one.- For several changes in one commit, use `-` bullets, one per change, naming the concrete classes or methods:

```
Remove dead code

- Remove #items from DTReRunConfiguration because it is never called
- Remove printing methods from KeyMapping because they call dead code
```

- If the commit fixes an issue, add a footer line: `Fixes #17606`.
- Do not hard-wrap. Each sentence or bullet stays on one line.
- Never add attribution lines to commit messages or PR descriptions, such as `Co-Authored-By: Claude` or "Generated with Claude Code". Keep only footers that already exist for a reason the user has, such as an issue link.

## Pull request

- Title: same rule as the commit subject.
- Description: a few plain sentences in first person when useful, for example "I propose to deprecate it" or "I'd like a review from @name". Name the related PRs as a plain list of links.
- Add a `Next step:` line when there is follow-up work.
- Use bullets for several changes. Use headings, tables or code samples only for a large change that is hard to explain otherwise.
- Do not use a fixed template.

## What to leave out

- The history of the work in the session. A bug introduced and fixed during the same session is not mentioned.
- Motivation that is not in the diff or the conversation. Leave out the "why" if it is not known.
- Filler: "This commit aims to", "various improvements", "enhance", "robust", "seamless", "comprehensive".
- A list of files touched. Name the behavior or the classes instead.

## Phrases to avoid

- "Previously", "Visible changes:", "Since Pharo N", and "Now, ..." at the start of a sentence. These describe a style written with agents, not the user's style.
- Long bodies that repeat the subject.

## Checks before writing

- Could the subject be shorter?
- Does the body say something the subject does not, and that a reviewer needs? If not, remove it.
- Is every bullet one line?
- Is there any Claude attribution line? If so, remove it.
