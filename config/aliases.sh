alias reload=". ~/.bashrc"

alias dc=docker-compose
alias g=git
alias l='ls -alrt'
alias ll='ls -l'
alias ls='ls'
alias path='echo -e ${PATH//:/\\n}'

__git_complete g _git
