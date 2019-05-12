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

function add() {
    git status -s -u | fzf -m --ansi | cut -c 4- | xargs git add
}

function rem() {
    git status -s -u | fzf -m | cut -c 4- | xargs rm
}

function reset() {
    git status -s -u | fzf -m | cut -c 4- | xargs git reset
}

fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" --tiebreak=index \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = 'ctrl-d' ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}
