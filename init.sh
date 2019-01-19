#!/bin/bash

set -e
set -o pipefail

DOTFILES=$(pwd)

# Create symlinks
$DOTFILES/link.sh
