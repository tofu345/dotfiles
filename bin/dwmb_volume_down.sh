#!/bin/sh

wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

pkill -RTMIN+1 dwmblocks # signal dwmblocks volume indicator to refresh
