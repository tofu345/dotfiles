#!/bin/sh

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

pkill -RTMIN+1 dwmblocks # signal dwmblocks volume indicator to refresh
