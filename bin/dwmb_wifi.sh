#!/bin/sh

nmcli | awk '/^wlan0: /{
    if ($2 == "connected") {
        split($0, info, " connected to ")
        print "^c#9ece6a^󰤨 " info[2] "^d^"
    } else print "^c#f7768e^󰀝 Disconnected^d^"
}'
