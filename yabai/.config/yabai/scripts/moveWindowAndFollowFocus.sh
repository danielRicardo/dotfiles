#!/bin/bash

DIR=""
LEFT="left"
RIGHT="right"

function focusWindow() {
  $(yabai -m window --focus $1)
}

function moveLeft() {
  $(yabai -m window --display prev || yabai -m window --display last)
}

function moveRight() {
  $(yabai -m window --display next || yabai -m window --display first)
}

function main() {
  curWindowId="$(yabai -m query --windows --window | jq -re ".id")"

  [ $DIR == $LEFT ] && moveLeft || moveRight

  focusWindow "$curWindowId"
}

while getopts 'lr' dir; do
  case "${dir}" in
    r)
      DIR=$RIGHT; break;;
    l)
      DIR=$LEFT; break;;
    *)
      exit 1
  esac
done

main
