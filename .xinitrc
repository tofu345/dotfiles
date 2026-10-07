#!/bin/sh

exec >& $HOME/.wm.log
export PATH="$PATH:$HOME/.local/bin"
export GTK_THEME=Adwaita:dark

userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xset s 1200 5 
xset dpms 1210 1210 1210
xset r rate 250 25
xss-lock -n ~/builds/xss-lock-dim-screen2.sh -- slock &

dunst &
dwmblocks &
gammastep -O 3000 &
picom -b &
xwallpaper --zoom ~/Pictures/Wallpapers/wallhaven-christ.png --daemon &

exec dwm
