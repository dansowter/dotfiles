alias reload=". ~/.bashrc"

alias cat=bat
alias dc=docker-compose
alias ds='git diff --staged'
alias fcd='cd $(fd -t d | fzf)'
alias g=git
alias gs='git status'
alias gti=git
alias l='exa --long --git'
alias ll='exa --tree --level=2 --long --git --all'
alias lll='exa --long --git --recurse --all'
alias ls='ls'
alias path='echo -e ${PATH//:/\\n}'
alias kt='tmux kill-session'
alias up='tmux-up tmux-panes.conf'
alias stopall='docker stop $(docker ps -a -q)'
alias removeall='docker rm -f $(docker ps -a -q)'
alias flushdns='sudo systemd-resolve --flush-caches'
alias sshadd='askpass.sh | ssh-add -'
alias gitcomplete='source /usr/share/bash-completion/completions/git'

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
