#!/bin/bash
input=$(cat)
GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'
CYAN=$'\033[36m'; MAG=$'\033[35m'; RST=$'\033[0m'
rate_segment() {
  local label=$1 percentage=$2 resets_at=$3 time_format=$4
  [ -z "$percentage" ] && return
  local rounded c=$GREEN reset_text=""
  if [ "$percentage" -ge 80 ]; then c=$RED; elif [ "$percentage" -ge 50 ]; then c=$YELLOW; fi
  [ -n "$resets_at" ] && reset_text=" (resets $(date -r "$resets_at" +"$time_format"))"
  printf '%s%s:%s%%%s%s' "$c" "$label" "$percentage" "$reset_text" "$RST"
}
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
out=""
if [ -n "$cwd" ]; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null \
    || GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  [ -n "$branch" ] && out="${MAG}git:${branch}${RST}"
fi
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used" ]; then
  u=$(printf '%.0f' "$used")
  if [ "$u" -ge 80 ]; then c=$RED; elif [ "$u" -ge 50 ]; then c=$YELLOW; else c=$GREEN; fi
  [ -n "$out" ] && out="$out | "
  out="${out}${c}ctx:${u}%${RST}"
fi
five_hour_percentage=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty | round')
five_hour_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day_percentage=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty | round')
seven_day_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')
for segment in "$(rate_segment session "$five_hour_percentage" "$five_hour_resets_at" %H:%M)" \
               "$(rate_segment week "$seven_day_percentage" "$seven_day_resets_at" '%a %H:%M')"; do
  [ -z "$segment" ] && continue
  [ -n "$out" ] && out="$out | "
  out="${out}${segment}"
done
model=$(echo "$input" | jq -r '.model.display_name // empty')
if [ -n "$model" ]; then
  [ -n "$out" ] && out="$out | "
  out="${out}${CYAN}model:${model}${RST}"
fi
printf '%s\n' "$out"
