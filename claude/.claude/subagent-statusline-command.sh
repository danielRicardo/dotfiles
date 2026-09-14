#!/usr/bin/env bash
RED=$'\033[31m'
YELLOW=$'\033[33m'
RESET=$'\033[0m'

input=$(cat)

while IFS=$'\x1f' read -r model total used cwd; do
  [ -z "$model" ] && continue
  out="$model"

  if [ -n "$total" ] && [ -n "$used" ]; then
    pct=$(awk -v u="$used" -v t="$total" 'BEGIN { printf "%.0f", (t > 0) ? (u / t * 100) : 0 }')
    if [ "$used" -ge 100000 ]; then
      color=$RED; reset=$RESET
    elif [ "$used" -ge 50000 ]; then
      color=$YELLOW; reset=$RESET
    else
      color=""; reset=""
    fi
    out=$(printf "%s | ctx: %s%s%s/%s (%s%%)" "$out" "$color" "$used" "$reset" "$total" "$pct")
  fi

  if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    [ -n "$branch" ] && out=$(printf "%s |  %s" "$out" "$branch")

    gitdir=$(git -C "$cwd" --no-optional-locks rev-parse --path-format=absolute --git-dir 2>/dev/null)
    commondir=$(git -C "$cwd" --no-optional-locks rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    if [ -n "$gitdir" ] && [ "$gitdir" != "$commondir" ]; then
      toplevel=$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null)
      [ -n "$toplevel" ] && out=$(printf "%s | wt:%s" "$out" "$(basename "$toplevel")")
    fi
  fi

  printf "%s\n" "$out"
done < <(
  echo "$input" | jq -r '
    (.tasks // [])[] | [
      (.model // "Unknown"),
      (.contextWindowSize // ""),
      ((.tokenCount // 0) | if . == 0 then "" else . end),
      (.cwd // "")
    ] | join("")
  '
)
