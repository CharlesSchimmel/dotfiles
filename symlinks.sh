#!/usr/bin/bash

pushd "$(dirname "$0")"

ln -s $PWD/aliases $HOME/.aliases
ln -s $PWD/inputrc $HOME/.inputrc
ln -s $PWD/vimrc $HOME/.vimrc
ln -s $PWD/xinitrc $HOME/.xinitrc
ln -s $PWD/Xresources $HOME/.Xresources
ln -s $PWD/Xresources.d $HOME/
ln -s $PWD/zshrc $HOME/.zshrc

mkdir -p $HOME/.config/kitty
ln -s $PWD/kitty $HOME/.config/

mkdir -p $HOME/.config/rofi
ln -s $PWD/rofi $HOME/.config/

mkdir -p $HOME/.config/xmonad
ln -s $PWD/xmonad/* $HOME/.config/xmonad/

mkdir -p $HOME/.config/beets
ln -s $PWD/beets/* $HOME/.config/beets/

mkdir -p $HOME/.config/nvim
ln -s $PWD/nvim/* $HOME/.config/nvim/

ln -s $PWD/stalonetrayrc $HOME/.stalonetrayrc

mkdir -p $HOME/.config/dunst
ln -s $PWD/dunst/* $HOME/.config/dunst/

popd
