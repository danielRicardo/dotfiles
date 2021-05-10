#!/bin/bash

set -e
set -o pipefail

mkdir -p ~/.tmux/plugins
[ -d ~/.tmux/plugins ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
echo "Press PREFIX + I to install the TMUX plugins"
