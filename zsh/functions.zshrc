fssh() {
    local sshLoginHost
    sshLoginHost=`cat ~/.ssh/config | grep -i ^host | awk '{print $2}' | fzf --height 40% --reverse`

    if [ "$sshLoginHost" = "" ]; then
        # ex) Ctrl-C.
        return 1
    fi

    ssh ${sshLoginHost}
}

faws() {
    local awsLoginHost
    awsLoginHost=`cat ~/.aws/config | grep -i '^\[profile' | awk '{print substr($2, 1, length($2)-1)}' | fzf --height 40% --reverse`
    if [ "$awsLoginHost" = "" ]; then
        return 1
    fi
    AWS_PROFILE=${awsLoginHost}
}

caws() {
    local awsLoginHost
    awsLoginHost=`cat ~/.aws/config | grep -i '^\[profile' | awk '{print substr($2, 1, length($2)-1)}' | fzf --height 40% --reverse`
    if [ "$awsLoginHost" = "" ]; then
        return 1
    fi
    echo ${awsLoginHost} | pbcopy
}

fghq () {
    local selected_dir=$(ghq list | grep -v "/archive/" | fzf --height 40% --reverse)
    target=$(ghq root)/$selected_dir
    if [ -n "$target" ]; then
        cd ${target}
        zle accept-line
    fi
}
zle -N fghq

fbr() {
  local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | perl -pne 's{^refs/heads/}{}' | fzf --query "$LBUFFER" --height 40% --reverse)

  if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
  fi

  zle reset-prompt
}
zle -N fbr

fhistory() {
  BUFFER=$(history -n -r 1 | fzf --reverse --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N fhistory

opr () {
  who=$(op whoami)
  if [[ $? != 0 ]]
  then
    eval $(op signin)
  fi
  if [[ -f "$PWD/.env" ]]
  then
    op run --env-file=$PWD/.env -- $@
  else
    op run --env-file='~/config/.env.1password' -- $@
  fi
}

alias fghqls='ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*"'
