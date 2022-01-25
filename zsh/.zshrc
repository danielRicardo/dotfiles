# PATH Management
path=("$HOME/bin" $path)
path+="/usr/local/bin"
path+="/usr/local/opt/fzf/bin"

# Add pip3 folder to path for all Scala tools
path+="$HOME/.local/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
path+="$HOME/.rvm/bin"

typeset -U PATH

export PATH

XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CONFIG_HOME

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="intheloop"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  common-aliases
  docker
  extract
  fzf
  git
  gitignore
  mvn
  sbt
  timer
  tmux
  vi-mode
  vscode
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias v="nvim"

EDITOR="/usr/local/bin/nvim"
DOTFILES="$HOME/workspace/dotfiles"


if [ -f "$HOME/.bash_aliases" ]; then
  source "$HOME/.bash_aliases"
fi

if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh" 
fi


# list directories before files (if installed version of ls allows this)
if man ls | grep group-directories-first >&/dev/null; then
  alias ls='ls --color=auto --group-directories-first'
fi

# glab aliases
alias gmcf='glab mr create --fill'
alias gmvw='glab mr view --web'
alias grvw='glab repo view --web'

# default settings for less. You may also want to disable line wrapping with -S
LESS='-MRi#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in prompt

# shell history is useful, let's have more of it
HISTFILESIZE=1000000
HISTSIZE=1000000
HISTFILE=~/.cache/zsh/history
HISTCONTROL=ignoredups   # don't store duplicated commands
#shopt -s histappend   # don't overwrite history file after each session

# Edit current command in vim with ctrl-E:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# vi-mode settings
VI_MODE_SET_CURSOR=true

# Use vim keys instead of arrows in menuselect
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^?' backward-delete-char

# TMUX Options
ZSH_TMUX_AUTOSTART_ONCE=true
ZSH_TMUX_AUTOCONNECT=true
ZSH_TMUX_AUTOQUIT=true

# Coursier Settings
COURSIER_INSTALL_DIR="$HOME/bin"

source $DOTFILES/zsh/functions

if [[ "$(hostname)" == "danielricardo.af" ]]; then
  source $HOME/bin/af_scripts
fi

