# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
