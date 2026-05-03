#!/usr/bin/env bash
RED=$'\033[31m'
YELLOW=$'\033[33m'
RESET=$'\033[0m'

input=$(cat)

IFS=$'\t' read -r model total used used_pct < <(
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
      (.context_window.used_percentage // "")
    ] | @tsv
  '
)

if [ -n "$total" ] && [ -n "$used" ] && [ -n "$used_pct" ]; then
  if [ "$used" -ge 100000 ]; then
    color=$RED; reset=$RESET
  elif [ "$used" -ge 50000 ]; then
    color=$YELLOW; reset=$RESET
  else
    color=""; reset=""
  fi
  printf "%s | ctx: %s%s%s/%s (%.0f%%)" "$model" "$color" "$used" "$reset" "$total" "$used_pct"
else
  printf "%s" "$model"
fi
