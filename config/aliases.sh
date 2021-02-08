alias reload=". ~/.bashrc"

alias cat=bat
alias cl='tput reset'
alias ds='git diff --staged'
alias fcd='cd $(fd -t d | fzf)'
alias flushdns='sudo systemd-resolve --flush-caches'
alias g=git
alias gd='git diff'
alias gitcomplete='source /usr/share/bash-completion/completions/git'
alias gs='git status'
alias gti=git
alias kt='tmux kill-session'
alias l='exa --long --git'
alias ll='exa --tree --level=2 --long --git --all'
alias lll='exa --long --git --recurse --all'
alias path='echo -e ${PATH//:/\\n}'
alias removeall='docker rm -f $(docker ps -a -q)'
alias sshadd='askpass.sh | ssh-add -'
alias stopall='docker stop $(docker ps -a -q)'
alias up='tmux source tmux-panes.conf'
alias yubi='ykman oath code arn:aws:iam::195859504095:mfa/dan_sowter | tail -c 7 | pbcopy'
alias getwayupcode='ykman oath code wayup | tail -c 7 | pbcopy'
alias dl='docker ps -a --format "{{.Names}}" | fzf | xargs -t docker logs'

function add() {
    git status -s -u | fzf -m --ansi | cut -c 4- | xargs git add
}

function rem() {
    git status -s -u | fzf -m --ansi | cut -c 4- | xargs rm
}

function prunebranches() {
    git branch | fzf -m --ansi | xargs git branch -D
}

function reset() {
    git status -s -u | fzf -m --ansi | cut -c 4- | xargs git reset
}

function danger() {
    export DANGER_ZONE=true
}

function run() {
cd ~/code/cosmos/scripts
script=$(fd . --no-ignore -e ts -e sh -t x | fzf)

cd ~/code/cosmos
[ -z "$IN_NIX_SHELL" ] && nix-shell

if [ ${script: -3} == ".ts" ]
then
    echo $script | xargs -p -I "selected" scripts/run selected
else
    echo "scripts/"$script | xargs -p bash
fi
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
