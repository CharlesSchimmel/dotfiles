#!/usr/bin/bash

pushd "$(dirname "$0")"

ln -s aliases $HOME/.aliases
ln -s inputrc $HOME/.inputrc
ln -s vimrc $HOME/.vimrc
if [[ -e $HOME/.vim ]]; then
    ln -s vim/ftplugin $HOME/.vim/ftplugin
fi
ln -s xinitrc $HOME/.xinitrc
ln -s Xresources $HOME/.Xresources
ln -s Xresources.d $HOME/
ln -s zshrc $HOME/.zshrc

mkdir -p $HOME/.config/kitty
ln -s kitty $HOME/.config/

mkdir -p $HOME/.config/rofi
ln -s rofi $HOME/.config/

mkdir -p $HOME/.config/xmonad
ln -s xmonad/* $HOME/.config/xmonad/

popd
