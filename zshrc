######## zsh ########
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zsh/zinit" && command chmod g-rwX "$HOME/.zsh"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zsh/zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zsh/zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zplugin
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zaw

[[ ! -f ~/.dotfiles/p10k.zsh ]] || source ~/.dotfiles/p10k.zsh

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

# alias
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls -al'
alias gs='git status'
alias ..='cd ..'
alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"
alias bat="batcat"
alias open='explorer.exe'
alias k=kubectl

source <(kubectl completion zsh)

# case ${OSTYPE} in
#   darwin*)
#     source ~/.dotfiles/zshrc/zshrc.darwin
#     ;;
#   linux*)
#     source ~/.dotfiles/zshrc/zshrc.linux
#     ;;
# esac
