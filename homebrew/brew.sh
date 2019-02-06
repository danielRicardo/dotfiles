#!/bin/bash

set -e
set -o pipefail

if test ! "$( command -v brew )"; then
    echo "Installing homebrew"
    ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
    echo "Installing mas"
    brew install mas
fi

if [ ! -f ~/.Brewfile ]; then
  echo "Please create ~/.Brewfile first"
  echo "You can use the link script to do it"
  exit 1
fi

echo -e "\\n\\nInstalling homebrew packages..."
echo "==============================="
brew bundle --global

# make fish the default shell
fish_path="$( command -v fish )"
if ! grep "$fish_path" /etc/shells; then
   echo "adding fish to /etc/shells"
   echo "$fish_path" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$fish_path" ]]; then
   chsh -s /usr/local/bin/fish
   echo "default shell changesd to $fish_path"
fi
