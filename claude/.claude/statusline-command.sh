#!/usr/bin/env bash
RED=$'\033[31m'
YELLOW=$'\033[33m'
RESET=$'\033[0m'

input=$(cat)

IFS=$'\x1f' read -r model total used used_pct cwd cost < <(
  echo "$input" | jq -r '
    [
      .model.display_name // "Unknown",
      (.context_window.context_window_size // ""),
      (
        (.context_window.current_usage // {})
        | ((.input_tokens // 0)
          + (.cache_creation_input_tokens // 0)
          + (.cache_read_input_tokens // 0)
          + (.output_tokens // 0))
        | if . == 0 then "" else . end
      ),
      (.context_window.used_percentage // ""),
      (.cwd // ""),
      (.cost.total_cost_usd // "")
    ] | join("")
  '
)

out="$model"

if [ -n "$total" ] && [ -n "$used" ] && [ -n "$used_pct" ]; then
  if [ "$used" -ge 100000 ]; then
    color=$RED; reset=$RESET
  elif [ "$used" -ge 50000 ]; then
    color=$YELLOW; reset=$RESET
  else
    color=""; reset=""
  fi
  out=$(printf "%s | ctx: %s%s%s/%s (%.0f%%)" "$out" "$color" "$used" "$reset" "$total" "$used_pct")
fi

if [ -n "$cwd" ] && git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
  [ -n "$branch" ] && out=$(printf "%s |  %s" "$out" "$branch")
fi

if [ -n "$cost" ]; then
  out=$(printf "%s | \$%.2f" "$out" "$cost")
fi

printf "%s" "$out"
