#
# ~/.bashrc
#

# https://github.com/ahmetb/kubectl-aliases
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
# Print the full command before running it
#function kubectl() { echo "+ kubectl $@">&2; command kubectl $@; }
### KUBECTL
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.

#$PATH variables
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export PATH=$HOME/.local/bin:$PATH
export PATH="${PATH}:${HOME}/.krew/bin"
export TERM=xterm-256color

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -al --color=auto'
#PS1='[\u@\h \W]\$ '  # To leave the default one
#DO NOT USE RAW ESCAPES, USE TPUT
reset=$(tput sgr0)
red=$(tput setaf 1)
blue=$(tput setaf 4)
green=$(tput setaf 2)

PS1='\[$red\]\u\[$reset\] \[$blue\]\w\[$reset\] \[$red\]\$ \[$reset\]\[$green\] '

# For basic completion use lines in the form of complete -cf your_command (these will conflict with the bash-completion settings)
complete -cf sudo
complete -cf man
complete -cf pacman
complete -cf pkgfile
complete -cf pactree
complete -F __start_kubectl k

# Bash history
export HISTTIMEFORMAT="%d/%m/%y %T "
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
export HISTCONTROL=ignoredups
export HISTIGNORE='history*'
export HISTSIZE='10000'
export HISTFILESIZE='10000'
export PROMPT_COMMAND='history -a;echo -en "\e]2;";history 1|sed "s/^[ \t]*[0-9]\{1,\}  //g";echo -en "\e\\";'
shopt -s histappend

# command not found
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

# cd when entering just path
shopt -s autocd

# Line wrap on window resize
shopt -s checkwinsize

# Dynamic page width
man() {
    local width=$(tput cols)
    [[ $width -gt $MANWIDTH ]] && width=$MANWIDTH
    env MANWIDTH=$width \
    man "$@"
}

# Default editor
export VISUAL="vim"

# Color Terminal for man pages
man() {
    LESS_TERMCAP_mb=$'\e'"[1;31m" \
    LESS_TERMCAP_md=$'\e'"[1;31m" \
    LESS_TERMCAP_me=$'\e'"[0m" \
    LESS_TERMCAP_se=$'\e'"[0m" \
    LESS_TERMCAP_so=$'\e'"[1;44;33m" \
    LESS_TERMCAP_ue=$'\e'"[0m" \
    LESS_TERMCAP_us=$'\e'"[1;32m" \
    command man "$@"
}

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

EDITOR=vim

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/nolche/yandex-cloud/path.bash.inc' ]; then source '/home/nolche/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/nolche/yandex-cloud/completion.bash.inc' ]; then source '/home/nolche/yandex-cloud/completion.bash.inc'; fi

