bak() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: bak <filename>" >&2
    return 1
  fi
  mv "$1" "$1.bak"
}