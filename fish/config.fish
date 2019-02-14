set -g -x WORKSPACE "/Users/ricardo/Documents/workspace"
set -g -x DOTFILES "$WORKSPACE/dotfiles"
set -g -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home

set PATH /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /Users/ricardo/Applications/apache-maven-3.6.0/bin /bin /sbin

source $DOTFILES/fish/.dy_config.fish

setenv SSH_ENV $HOME/.ssh/environment

set -g -x EDITOR /usr/local/bin/vim
alias ctags="/usr/local/bin/ctags"
alias cat="/usr/local/bin/bat"

alias git="/usr/local/bin/hub"

if [ -n "$SSH_AGENT_PID" ] 
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end  
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end  
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else 
        start_agent
    end  
end

set -g -x FZF_LEGACY_KEYBINDINGS 0
set -g -x FZF_COMPLETE 3
# ensure_tmux_is_running
