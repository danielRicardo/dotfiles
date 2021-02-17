#!/bin/bash

set -e
set -o pipefail

export DOTFILES=$(pwd)

for file in $(ls *.sh); do
	chmod +x ${file}
done

# Create symlinks
$DOTFILES/link.sh

# Set apple sensible defaults
$DOTFILES/apple_setup.sh
