#!/bin/sh

if [ $# != 1 ]; then
  echo "Expected 1 argument but found $#."
  exit 1
fi

case "$1" in
  "mute") wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle;;
  "down") wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-;;
  "up") wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0;;
esac

pkill -RTMIN+1 dwmblocks # refresh dwmblocks volume
