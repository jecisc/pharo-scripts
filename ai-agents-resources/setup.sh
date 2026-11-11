#!/bin/bash
# Set up this machine with the AI agent customisations (Claude Code + opencode).
# Safe to re-run. Never overwrites a real file: it warns and leaves it alone.
# Keep this script up to date when you add a skill, plugin, config, or tool.
set -uo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
MISSING=0

ok()   { echo "  [ok] $*"; }
warn() { echo "  [!!] $*"; }
info() { echo "       $*"; }
section() { echo; echo "== $*"; }

# link TARGET SOURCE: create a symlink unless something real is in the way
link() {
  local target=$1 src=$2
  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
    ok "$target"
  elif [ -e "$target" ] && [ ! -L "$target" ]; then
    warn "$target exists and is not a symlink. Move it aside and re-run."
  else
    mkdir -p "$(dirname "$target")"
    ln -sfn "$src" "$target" && ok "linked $target"
  fi
}

# render TEMPLATE TARGET: fill {{HOME}} and {{REPO}} and write only if TARGET is absent
render() {
  local template=$1 target=$2
  if [ -e "$target" ]; then
    ok "$target already exists (left unchanged)"
    return
  fi
  mkdir -p "$(dirname "$target")"
  sed -e "s#{{HOME}}#$HOME#g" -e "s#{{REPO}}#$REPO#g" "$template" > "$target" \
    && ok "created $target from template"
}

section "Prerequisites"
check() {  # check COMMAND HINT
  if command -v "$1" >/dev/null 2>&1; then
    ok "$1: $(command -v "$1")"
  else
    warn "$1 is missing. $2"
    MISSING=1
  fi
}
check git     "Install Xcode Command Line Tools: xcode-select --install"
check python3 "Install Python 3 (for example: brew install python)"
check jq      "Needed by the status line. Install: brew install jq"
check claude  "Install Claude Code, then re-run this script."
check opencode "Install opencode, then re-run this script."

if [ "$MISSING" -eq 1 ]; then
  echo
  warn "Fix the missing prerequisites above, then re-run ./setup.sh"
  exit 1
fi

section "Claude Code: status line"
link "$HOME/.claude/statusline-command.sh" "$REPO/claude/statusline-command.sh"

section "Claude Code: task-list plugin source"
link "$HOME/.claude/my-mods/task-list" "$REPO/claude/task-list"

section "Claude Code: settings and global instructions"
render "$REPO/claude/templates/settings.json" "$HOME/.claude/settings.json"
render "$REPO/claude/templates/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

section "Skills (Claude Code + opencode)"
"$REPO/scripts/link-skills.sh"

section "opencode"
OC_CONFIG="$HOME/.config/opencode/opencode.jsonc"
if [ -e "$OC_CONFIG" ]; then
  ok "$OC_CONFIG already exists (left unchanged)"
  if grep -q "$REPO/AGENTS.md" "$OC_CONFIG"; then
    ok "instructions point to $REPO/AGENTS.md"
  else
    warn "instructions do not point to $REPO/AGENTS.md. Check the file."
  fi
  if grep -q "REPLACE_WITH_YOUR_KEY" "$OC_CONFIG"; then
    warn "Set your API key in $OC_CONFIG (apiKey still has the placeholder)."
  fi
else
  render "$REPO/opencode/opencode.template.jsonc" "$OC_CONFIG"
  warn "Set your API key in $OC_CONFIG (replace REPLACE_WITH_YOUR_KEY)."
fi

section "Backlogs (live lists are not in git)"
mkdir -p "$REPO/backlog/archive"
[ -e "$REPO/backlog/agent-findings.md" ] || { printf '# Agent findings\n\n---\n' > "$REPO/backlog/agent-findings.md"; ok "created empty agent-findings.md"; }
[ -e "$REPO/backlog/user-backlog.md" ]  || { printf '# User backlog\n\n---\n' > "$REPO/backlog/user-backlog.md"; ok "created empty user-backlog.md"; }
info "Your previous lists are not in git. Copy them over from your old machine if you want them."

section "Manual steps (cannot be scripted)"
info "1. Claude Code, inside a session:"
info "     /plugin marketplace add $REPO/claude/task-list   (only if the cyril-mods marketplace is missing)"
info "     /plugin install task-list@cyril-mods"
info "     /plugin install mattpocock-skills@claude-plugins-official"
info "     /plugin install gitkraken-hooks@gitkraken        (or install GitKraken and its Claude integration)"
info "     then /reload-plugins and /restart"
info "2. opencode: GitKraken plugin gk-hooks.js in ~/.config/opencode/plugins/ comes from GitKraken."
info "3. Pharo repo: clone your pharo repo to ~/Library/Preferences/pharo so that $REPO exists."

echo
ok "Setup finished. Check the [!!] lines above."
