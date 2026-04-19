alias ..='cd ..'
alias l='ls'
alias ll='ls -al'

alias gs='git status'
alias main='git checkout main'
alias master='git checkout master'
alias push='git push -u origin HEAD'


alias hex2dec="printf '%d\n'"
alias dec2hex="printf '%x\n'"
# urlencoding
# https://www.webdevqa.jp.net/ja/shell-script/url%E3%82%A8%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0%E3%81%AE%E3%83%87%E3%82%B3%E3%83%BC%E3%83%89%EF%BC%88%E3%83%91%E3%83%BC%E3%82%BB%E3%83%B3%E3%83%88%E3%82%A8%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%87%E3%82%A3%E3%83%B3%E3%82%B0%EF%BC%89/960793177/amp/
alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))"'

alias awsaccount='aws sts get-caller-identity'
alias doc='docker compose'

alias pn='pnpm'
