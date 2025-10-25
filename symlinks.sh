#!/usr/bin/bash

pushd "$(dirname "$0")"

# ln -s $PWD/aliases $HOME/.aliases
# ln -s $PWD/inputrc $HOME/.inputrc
# ln -s $PWD/vimrc $HOME/.vimrc
# ln -s $PWD/xinitrc $HOME/.xinitrc
# ln -s $PWD/Xresources $HOME/.Xresources
# ln -s $PWD/Xresources.d $HOME/
ln -s $PWD/zshrc-common $HOME/.zshrc-common
if [ -z "$PWD/zshrc" ]; then
    cp $PWD/zshrc $HOME/.zshrc
fi

mkdir -p $HOME/.local/share/
ln -s $PWD/lscolors.sh $HOME/.local/share/lscolors.sh

# mkdir -p $HOME/.config/rofi
# ln -s $PWD/rofi $HOME/.config/

# mkdir -p $HOME/.config/xmonad
# ln -s $PWD/xmonad/* $HOME/.config/xmonad/

# mkdir -p $HOME/.config/beets
# ln -s $PWD/beets/* $HOME/.config/beets/

mkdir -p $HOME/.config/nvim
ln -s $PWD/nvim/* $HOME/.config/nvim/

# ln -s $PWD/stalonetrayrc $HOME/.stalonetrayrc

# mkdir -p $HOME/.config/dunst
# ln -s $PWD/dunst/* $HOME/.config/dunst/

# mkdir -p $HOME/.config/kmonad
# ln -s $PWD/kmonad/* $HOME/.config/kmonad/


popd
