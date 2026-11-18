#!/bin/sh

exec >& $HOME/.wm.log
export PATH="$PATH:$HOME/.local/bin"
export GTK_THEME=Adwaita:dark
export NO_AT_BRIDGE=1 # disable at-spi-bus-launcher https://bbs.archlinux.org/viewtopic.php?id=237697

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

xset s 1200 5 \
     dpms 1210 1210 1210 \
     r rate 250 25
xss-lock -n ~/builds/xss-lock-dim-screen2.sh -- slock &
xwallpaper --zoom ~/Pictures/Wallpapers/wallhaven-christ.png &
gammastep -O 3000

dunst &
dwmblocks &
/usr/libexec/polkit-mate-authentication-agent-1 &
playerctld &
sb-upd-mpris &

exec dwm
