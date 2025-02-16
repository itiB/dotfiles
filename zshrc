typeset -U path PATH
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

[[ ! -f ~/.dotfiles/zsh/p10k.zsh ]] || source ~/.dotfiles/zsh/p10k.zsh

######## HISTORY ########
export HISTFILE=${HOME}/.zsh/zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

######## AUTO COMPLETE ########
autoload -U compinit
compinit -u
autoload -U colors # 補完候補に色つける
colors
zstyle ':completion:*' list-colors "${LS_COLORS}"
setopt complete_in_word                         # 単語の入力途中でもTab補完を有効化
zstyle ':completion:*:default' menu select=1    # 補完候補をハイライト
zstyle ':completion::complete:*' use-cache true # キャッシュの利用による補完の高速化
setopt list_packed                              # 補完リストの表示間隔を狭く
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 大文字、小文字を区別せず補完

case ${OSTYPE} in
  darwin*)
    alias ls='ls -G'
    source ~/.dotfiles/zsh/darwin.zshrc
    ;;
  linux*)
    alias ls='ls --color=auto'
    if [[ "$(uname -r)" == *microsoft* ]]; then
      source ~/.dotfiles/zsh/wsl.zshrc
    else
      source ~/.dotfiles/zsh/linux.zshrc
    fi
    ;;
esac

# ######## TOOLS ########
path=(${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin(N-/) $path)
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml

export EDITOR=vim
if command -v kubectl &> /dev/null; then
    source <(kubectl completion zsh)
    KUBECONFIG=$KUBECONFIG:~/.kube/config
fi
eval "$(direnv hook zsh)"
path=($HOME/go/bin(N-/) $path)
path=($HOME/.local/bin(N-/) $path)
path=(/usr/local/go/bin(N-/) $path)
# export GOROOT=`go1.22.4 env GOROOT`

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
source ~/.dotfiles/zsh/arias.zshrc
source ~/.dotfiles/zsh/functions.zshrc

# コマンドの打ち間違いを指摘してくれる
setopt correct
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [Yes/No/Abort/Edit] => "
