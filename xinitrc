#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Remap Caps to act as Ctrl when held, escape when tapped
setxkbmap -option 'caps:ctrl_modifier'; xcape -e '#66=Escape'
xcape -e 'Shift_R=BackSpace'

# Space + hjkl = arrow keys. Sometimes dropsspaces when typing...
# xmodmap -e "keycode 65 = Mode_switch"
# xmodmap -e "keysym h = h H Left"
# xmodmap -e "keysym j = j J Down"
# xmodmap -e "keysym k = k K Up"
# xmodmap -e "keysym l = l L Right"
# xmodmap -e "keycode any = space"
# xcape -e 'Mode_switch=space'

# Tap Enter = Enter; Hold Enter = Alt
# Map an unused modifier's keysym to Return keycode and make it a
# control modifier. It needs to be an existing key so that apps won't
# spazz out when you press it. Hyper_L is a good candidate.
# spare_mod="Hyper_L"
# xmodmap -e "keycode 36 = $spare_mod"
# xmodmap -e "remove mod4 = $spare_mod"
# xmodmap -e "add Alt_L = $spare_mod"
# Map return to an unused keycode (to keep it around for xcape to use).
# xmodmap -e "keycode any = Return"
# Finally use xcape to cause the return bar to generate a return when tapped.
# xcape -e "$spare_mod=Return"

setxkbmap -layout dvorak
touch /tmp/q_to_d
exec i3
# exec gnome-session
# exec xfce4-session
# exec bspwm
# exec awesome
