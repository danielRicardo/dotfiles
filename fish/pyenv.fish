set -gx PYENV_ROOT $HOME/.pyenv
set PATH $PYENV_ROOT/bin $PATH 

# pyenv init
if command -v pyenv 1>/dev/null 2>&1
	pyenv init - | source
end
