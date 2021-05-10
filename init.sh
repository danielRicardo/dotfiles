#!/bin/bash

set -e
set -o pipefail

export -g DOTFILES=$(pwd)

for file in $(ls *.sh); do
	chmod +x ${file}
done

# Create symlinks
$DOTFILES/link.sh

# Set apple sensible defaults
$DOTFILES/apple_setup.sh

# Initialize tmux plugins manager and install plugins
$DORFILES/tmux/tpm_init.sh

# Initialize vim plugins
$DOTFILES/vim/vundle_init.sh
