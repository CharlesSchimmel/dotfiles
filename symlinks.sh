#!/usr/bin/bash

ln -s $HOME/dots/aliases $HOME/.aliases
ln -s $HOME/dots/inputrc $HOME/.inputrc
ln -s $HOME/dots/vimrc $HOME/.vimrc
if [[ -e $HOME/.vim ]]; then
    ln -s $HOME/dots/vim/ftplugin $HOME/.vim/ftplugin
fi
ln -s $HOME/dots/xinitrc $HOME/.xinitrc
ln -s $HOME/dots/Xresources $HOME/.Xresources
ln -s $HOME/dots/Xresources.d $HOME/.Xresources.d
ln -s $HOME/dots/zshrc $HOME/.zshrc
