eval "$(starship init zsh)"

typeset -U path PATH

eval "$(fzf --zsh)"

source ~/.dotfiles/zsh/alias.zshrc
source ~/.dotfiles/zsh/functions.zshrc


case ${OSTYPE} in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # alias
    alias clip='pbcopy'
    alias ls='ls -G'

    if type brew &>/dev/null; then
      source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
      autoload -Uz compinit
      compinit
    fi
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
eval "$(mise activate zsh)"
export PATH="$(aqua root-dir)/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aquaproj-aqua/aqua.yaml
export PATH="$HOME/.local/bin:$PATH"
