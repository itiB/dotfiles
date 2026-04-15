eval "$(starship init zsh)"

typeset -U path PATH

source ~/zsh/fzf.zshrc
source ~/zsh/alias.zshrc


case ${OSTYPE} in
  darwin*)
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # alias
    alias clip='pbcopy'
    alias ls='ls -G'

    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
