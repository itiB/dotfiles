eval "$(/opt/homebrew/bin/brew shellenv)"

# need setting to iterm2
bindkey '^[fhistory' fhistory
bindkey '^[fbr' fbr
bindkey '^[clear-screen' clear-screen

# rm Less's ESC[
export LESS="-iRMXS"

# alias
alias clip='pbcopy'
