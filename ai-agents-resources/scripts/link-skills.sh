#!/bin/bash
# Links every skill of the source folders into the Claude Code and opencode global skill folders:
# - the personal skills in ~/Library/Preferences/pharo/ai-agents-resources/skills
# - the Pharo MCP skills in the Evref-BL/MCP clone, when that clone exists
set -euo pipefail

SOURCES=(
  "$HOME/Library/Preferences/pharo/ai-agents-resources/skills"
  "$HOME/Library/Preferences/pharo/GitRepositories/Evref-BL/MCP/templates/pharo-skills"
)
TARGETS=("$HOME/.claude/skills" "$HOME/.config/opencode/skills")

for src in "${SOURCES[@]}"; do
  if [ ! -d "$src" ]; then
    echo "SKIP $src does not exist"
    continue
  fi
  for dir in "$src"/*/; do
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
done
