#!/bin/sh

exec >& $HOME/.dwm.log

sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userresources=$HOME/.Xresources

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export GTK_THEME=Adwaita:dark

xss-lock -n ~/builds/xss-lock-dim-screen2.sh -- slock &
xset s 1200 5 &
xset dpms 1210 1210 1210 &

dunst &
dwmblocks &
gammastep -O 4000 &
picom -b &
xwallpaper --zoom ~/Pictures/Wallpapers/wallhaven-christ.png --daemon &

exec dwm
