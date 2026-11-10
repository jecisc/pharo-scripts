#!/bin/bash
# Links every personal skill in ~/Library/Preferences/pharo/ai-agents-resources/skills into the
# Claude Code and opencode global skill folders.
set -euo pipefail

SRC="$HOME/Library/Preferences/pharo/ai-agents-resources/skills"
TARGETS=("$HOME/.claude/skills" "$HOME/.config/opencode/skills")

for dir in "$SRC"/*/; do
  [ -f "${dir}SKILL.md" ] || continue
  name=$(basename "$dir")
  for target in "${TARGETS[@]}"; do
    mkdir -p "$target"
    link="$target/$name"
    if [ -e "$link" ] && [ ! -L "$link" ]; then
      echo "SKIP $link exists and is not a symlink; not touching it"
      continue
    fi
    ln -sfn "${dir%/}" "$link"
    echo "linked $link -> ${dir%/}"
  done
done
