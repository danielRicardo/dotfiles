# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export DOTFILES='~/workspace/dotfiles'

# list directories before files (if installed version of ls allows this)
if man ls | grep group-directories-first >&/dev/null; then
  alias ls='ls --color=auto --group-directories-first'
fi

# default settings for less. You may also want to disable line wrapping with -S
export LESS='-MRi#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in prompt

# default settings for grep
export GREP_OPTIONS='--color --binary-files=without-match --exclude-dir .git'

# ALIASES

# common ls aliases
alias l='ls -FB'  # --classify --ignore-backups
alias la='ls -FA'  # --classify --almost-all
alias ll='ls -Flah'  # --classify --all --human-readable'

# this will color matches even when output to a non-tty (e.g. piped to less)
alias grep3='grep --color=always --line-number --context=3'

# Some commands are so common that they deserve one-letter shortcuts :)
alias g='git'
alias v='vim'
alias L='less'

# Aliasing 'g' to 'git' wouldn't be useful without autocompletion.
complete -o default -o nospace -F _git g
. /usr/share/bash-completion/completions/git 2> /dev/null

# Chef aliases
alias cco='sudo chef-client -—once'
alias ccs='sudo service chef-client stop'

# supervisor aliases
alias scs='sudo supervisorctl status'
alias scr='sudo supervisorctl restart'
alias sck='sudo supervisorctl stop'
alias sct='sudo supervisorctl start'


# SETTINGS

# enable autocompletion and make it case-insensitive
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi
bind "set completion-ignore-case on"

# let aliases work after sudo (see http://askubuntu.com/a/22043)
alias sudo='sudo '

# cd to a dir just by typing its name (requires bash > 4.0), autocorrect typos
[ ${BASH_VERSION:0:1} -ge 4 ] && shopt -s autocd
shopt -s cdspell

# shell history is useful, let's have more of it
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups   # don't store duplicated commands
shopt -s histappend   # don't overwrite history file after each session

# disable useless flow control binding, allowing Ctrl-S to search history forward
stty -ixon


# PROMPT

# Colored prompt makes it easier to visually parse terminal output. Note that
# using \[ and \] is necessary to prevent weird behavior (lines overlapping).

# I'm using bright colors because in most terminal palettes the "normal" ones
# (\e[35m, \e[34m and \e[36m) are too dim - feel free to adjust.
if [ -n "$SSH_CONNECTION" ]; then  # connected through SSH?
  usercolor="\[\e[95m\]"  # yes -> magenta
else
  usercolor="\[\e[94m\]"  # no -> blue
fi
pathcolor="\[\e[96m\]"  # cyan path
resetcolors="\[\e[0m\]"

# $(__git_ps1) displays git repository status in the prompt - very handy!
# Read more: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="verbose git"

# we don't want "command not found" errors when __git_ps1 is not installed
type __git_ps1 &>/dev/null || function __git_ps1 () { true; }

export PS1="${usercolor}\u@\h${pathcolor} \w${resetcolors}\$(__git_ps1)\\$ "

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# list directories before files (if installed version of ls allows this)
if which exa >&/dev/null; then
  alias ls='exa --group-directories-first --git'
elif which man >&/dev/null && man ls | grep group-directories-first >&/dev/null ; then
  alias ls='ls --color=auto --group-directories-first'
else
  alias ls='ls --color=auto'
fi

# default settings for less. You may also want to disable line wrapping with -S
export LESS='-MRi#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in prompt

# default settings for grep
export GREP_OPTIONS='--color --binary-files=without-match --exclude-dir .git'

# ALIASES

# common ls aliases
alias l='ls -FB'  # --classify --ignore-backups
alias la='ls -FA'  # --classify --almost-all
alias ll='ls -Flah'  # --classify --all --human-readable'

# this will color matches even when output to a non-tty (e.g. piped to less)
alias grep3='grep --color=always --line-number --context=3'

# Some commands are so common that they deserve one-letter shortcuts :)
alias g='git'
alias v='vim'
alias L='less'

# Aliasing 'g' to 'git' wouldn't be useful without autocompletion.
complete -o default -o nospace -F _git g
. /usr/share/bash-completion/completions/git 2> /dev/null

# Chef aliases
alias cco='sudo chef-client -—once'
alias ccs='sudo service chef-client stop'

# supervisor aliases
alias scs='sudo supervisorctl status'
alias scr='sudo supervisorctl restart'
alias sck='sudo supervisorctl stop'
alias sct='sudo supervisorctl start'


# SETTINGS

# enable autocompletion and make it case-insensitive
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi
bind "set completion-ignore-case on"

# let aliases work after sudo (see http://askubuntu.com/a/22043)
alias sudo='sudo '

# cd to a dir just by typing its name (requires bash > 4.0), autocorrect typos
[ ${BASH_VERSION:0:1} -ge 4 ] && shopt -s autocd
shopt -s cdspell

# shell history is useful, let's have more of it
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoredups   # don't store duplicated commands
shopt -s histappend   # don't overwrite history file after each session

# disable useless flow control binding, allowing Ctrl-S to search history forward
stty -ixon


# PROMPT

# Colored prompt makes it easier to visually parse terminal output. Note that
# using \[ and \] is necessary to prevent weird behavior (lines overlapping).

# I'm using bright colors because in most terminal palettes the "normal" ones
# (\e[35m, \e[34m and \e[36m) are too dim - feel free to adjust.
if [ -n "$SSH_CONNECTION" ]; then  # connected through SSH?
  usercolor="\[\e[95m\]"  # yes -> magenta
else
  usercolor="\[\e[94m\]"  # no -> blue
fi
pathcolor="\[\e[96m\]"  # cyan path
resetcolors="\[\e[0m\]"

# $(__git_ps1) displays git repository status in the prompt - very handy!
# Read more: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="verbose git"

# we don't want "command not found" errors when __git_ps1 is not installed
type __git_ps1 &>/dev/null || function __git_ps1 () { true; }

export PS1="${usercolor}\u@\h${pathcolor} \w${resetcolors}\$(__git_ps1)\\$ "


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
