# Defined in /Users/ricardo/.config/fish/functions/mssh.fish @ line 2
function mssh
  $DOTFILES/bin/mssh.sh -d (string join ' ' $argv)
end
