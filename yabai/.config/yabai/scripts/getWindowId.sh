#!/bin/bash

set -e 
set -o pipefail

WINDOWS=$(yabai -m query --windows)

if [[ -n $1 ]]; then
  echo "$WINDOWS" | jq ".[] | select(.app|test(\".*$1.*\"; \"i\")) | .id"
else
  APP_NAME=$(echo "$WINDOWS" | jq '.[] | .app' | fzf)
  echo "$WINDOWS" | jq ".[] | select(.app == $APP_NAME) | .id" 
fi

