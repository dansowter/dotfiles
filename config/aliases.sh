alias reload=". ~/.bashrc"

alias dc=docker-compose
alias g=git
alias gti=git
alias l='ls -alrt'
alias ll='ls -l'
alias ls='ls'
alias path='echo -e ${PATH//:/\\n}'
alias fcd='cd $(fd -t d | fzf)'
alias code='code-insiders'
alias cat=bat

__git_complete g _git
