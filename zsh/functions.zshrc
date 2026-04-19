bak() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: bak <filename>" >&2
    return 1
  fi
  mv "$1" "$1.bak"
}

export FZF_DEFAULT_OPTS="--height 40% --reverse --border"

fghq() {
  local dir
  dir=$(ghq list -p | fzf) || return
  cd "$dir"
}
zle -N fghq
bindkey "\e[CmdG" fghq


fbr() {
  local selected_branch
  selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf --query "$LBUFFER") || return
  git checkout ${selected_branch}
}
zle -N fbr
bindkey "\e[CmdB" fbr

fdoc() {
  local cid
  cid=$(docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}" | fzf --header-lines=1 --reverse | awk '{print $1}') || return
  echo "$cid"
}
# 例: docker logs $(fdoc)  や docker exec -it $(fdoc) sh

faws() {
  local awsProfile
  awsProfile=$(aws configure list-profiles | fzf) || return 
  export AWS_PROFILE=awsProfile
  echo "Switched to: $AWS_PROFILE"
}

fhistory() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N fhistory
bindkey "\e[CmdH" fhistory


