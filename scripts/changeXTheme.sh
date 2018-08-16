#!/bin/bash

changegtk () {
    if [[ -e "/usr/share/themes/$1" ]] || [[ -e "$HOME/.themes/$1" ]]; then
        sed -r -i "s/gtk-theme-name.+?/gtk-theme-name=$1/g" "$HOME/.config/gtk-3.0/settings.ini"
        sed -r -i "s/gtk-theme-name.+?/gtk-theme-name=\"$1\"/g" "$HOME/.gtkrc-2.0"
    else
        echo "gtk theme not found."
    fi
}

changeVimperator () {
    if [[ -e "$HOME/.vimperator/colors/$1.vimp" ]]; then
        sed -r -i "s/colorscheme.+?/colorscheme $1/g" "$HOME/.vimperatorrc"
    else
        echo "Vimperator theme not found."
    fi
}


if [[ $1 ]]; then
    if [[ -e "$HOME/.Xresources.d/themes/$1" ]]; then

        # look for an accompanying gtk theme in the theme file
        gtktheme=$(cat "$HOME/.Xresources.d/themes/$1" | grep -E -i "gtk")
        if [[ $? -eq 0 ]]; then
            gtktheme=$(echo "$gtktheme" | sed -r "s/^\*gtk: //")
            changegtk "$gtktheme"
        fi

        changeVimperator $1

        # Changes the include statement for the desired theme
        sed -i -r "s/themes.+?$/themes\/$1\"/g" "$HOME/.Xresources"

        # Creates a "colors" file that defines the colors so rofi can use them
        echo "! $1 theme" > "$HOME/.Xresources.d/colors"
        grep -E "^\*" "$HOME/.Xresources.d/themes/$1" | sed 's/*/#define /g' | sed 's/://g' >> "$HOME/.Xresources.d/colors"

        # Pull the background hex, rename it, add "dd" to the end so i3 can use it as an alpha
        cat "$HOME/.Xresources.d/themes/$1" | grep background | sed -r "s/background/backgroundAlpha/g" | sed -r "s/$/dd/g" >> "$HOME/.Xresources.d/colors"

        # Load xrdb
        xrdb -load "$HOME/.Xresources"
        # Restart i3
        i3 restart >/dev/null 2>&1

    else
        echo "No such theme."
    fi

else
    echo "Need a theme to change to..."
    ls $HOME/.Xresources.d/themes
fi
