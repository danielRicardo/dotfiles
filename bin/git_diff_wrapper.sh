#!/bin/bash
if [ "$2" = "/dev/null" ]; then
  vim $1
else
  </dev/tty vimdiff "$1" "$2"
fi
