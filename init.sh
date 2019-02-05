#!/bin/bash

set -e
set -o pipefail

DOTFILES=$(pwd)

for file in (ls *.sh)
	chmod +x $file
end

# Create symlinks
$DOTFILES/link.sh

# Set apple sensible defaults
$DOTFILES/apple_setup.sh
