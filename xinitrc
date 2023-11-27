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

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Remap Caps to act as Ctrl when held, escape when tapped
setxkbmap -option 'caps:ctrl_modifier'; xcape -e '#66=Escape'
xcape -e 'Shift_R=BackSpace'
xcape -e 'Shift_L=Tab'
setxkbmap -layout dvorak
touch /tmp/q_to_d
$HOME/.local/bin/kmonad $HOME/.config/kmonad/elpfen.kbd &

/usr/bin/prime-offload # initialize optimus-manager

xinput set-prop 12 322 1 # fix trackpad tap

$HOME/.local/bin/xmonad
# xfce4-session

# exec i3
# exec gnome-session
# exec bspwm
# exec awesome

sudo /usr/bin/prime-switch
exit
