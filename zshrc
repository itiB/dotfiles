######## zsh ########
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
if [[ ! -f ${ZINIT_HOME}/zinit/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}/zinit" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "${ZINIT_HOME}/zinit/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zplugin
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zaw

# LOCAL
[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
[[ ! -f ~/.dotfiles/zsh/p10k.zsh ]] || source ~/.dotfiles/zsh/p10k.zsh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


######## HISTORY ########
export HISTFILE=${HOME}/.zsh/zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

bindkey '^x' zaw-history
bindkey '^b' zaw-git-branches

######## ALIAS ########
alias ..='cd ..'
alias l='ls'
alias ll='ls -al'

alias gs='git status'

alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"
# urlencoding
# https://www.webdevqa.jp.net/ja/shell-script/url%E3%82%A8%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0%E3%81%AE%E3%83%87%E3%82%B3%E3%83%BC%E3%83%89%EF%BC%88%E3%83%91%E3%83%BC%E3%82%BB%E3%83%B3%E3%83%88%E3%82%A8%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0%EF%BC%89/960793177/amp/
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

alias bat="batcat"
alias k="kubectl"
alias tf="terraform"
alias awsaccount='aws sts get-caller-identity'
alias doc='docker-compose'
alias d_rm='docker ps -aq | xargs docker rm'
alias d_rmi='docker images -aq | xargs docker rmi'

source <(kubectl completion zsh)

##### TOOLS #####
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


case ${OSTYPE} in
  darwin*)
    alias ls='ls -G'
    # source ~/.dotfiles/zsh/zshrc.darwin
    ;;
  linux*)
    alias ls='ls --color=auto'
    if [[ "$(uname -r)" == *microsoft* ]]; then
      source ~/.dotfiles/zsh/zshrc.wsl
    # else
    #   source ~/.dotfiles/zsh/zshrc.linux
    fi
    ;;
esac
