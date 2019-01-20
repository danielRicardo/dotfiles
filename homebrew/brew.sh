#!/bin/bash

set -e
set -o pipefail

if test ! "$( command -v brew )"; then
    echo "Installing homebrew"
    ruby -e "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install )"
fi

echo -e "\\n\\nInstalling homebrew packages..."
echo "=============================="

formulas=(
    bat
    git
    'grep --with-default-names'
    fish
    hub
    'macvim --with-override-system-vim'
#    neovim
    node
    n
    python
    reattach-to-user-namespace
    the_silver_searcher
    shellcheck
    tmux
#    trash
    wget
    z
    ripgrep
#    git-standup
    entr
    git-secrets
)

for formula in "${formulas[@]}"; do
    formula_name=$( echo "$formula" | awk '{print $1}' )
    if brew list "$formula_name" > /dev/null 2>&1; then
        echo "$formula_name already installed... skipping."
    else
        brew install "$formula"
    fi
done

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
