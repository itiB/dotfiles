ROOT=$(
  cd $(dirname $0)
  pwd
)

mkdir ~/.config

rm -rf ~/.config/wezterm
ln -s $ROOT/wezterm ~/.config/wezterm

rm -rf ~/.config/aquaproj-aqua
ln -s $ROOT/aquaproj-aqua ~/.config/aquaproj-aqua

rm ~/.zshrc
ln -s $ROOT/zshrc ~/.zshrc

rm ~/.config/starship.toml
ln -s $ROOT/starship/starship.toml ~/.config/starship.toml

