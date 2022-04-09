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

[[ ! -f ~/.dotfiles/zsh/p10k.zsh ]] || source ~/.dotfiles/zsh/p10k.zsh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


######## HISTORY ########
export HISTFILE=${HOME}/.zsh/zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

bindkey '^x' zaw-history
bindkey '^b' zaw-git-branches

######## ALIAS ########
alias ..='cd ..'
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls -al'

alias gs='git status'

alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"

alias bat="batcat"

alias k=kubectl
source <(kubectl completion zsh)

case ${OSTYPE} in
  # darwin*)
  #   source ~/.dotfiles/zsh/zshrc.darwin
  #   ;;
  linux*)
    if [[ "$(uname -r)" == *microsoft* ]]; then
      source ~/.dotfiles/zsh/zshrc.wsl
    # else
    #   source ~/.dotfiles/zsh/zshrc.linux
    fi
    ;;
esac
