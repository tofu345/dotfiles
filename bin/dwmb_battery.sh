#!/usr/bin/env bash
# Originally By: Jake@Linux https://gitlab.com/jped/scripts/-/blob/main/batt.sh?ref_type=heads

status="$(cat /sys/class/power_supply/BAT0/status)"
level="$(cat /sys/class/power_supply/BAT0/capacity)"
icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")

color=""
if [[ $status != 'Discharging' ]]; then
    color="#9ece6a"
elif [[ $status = 'Discharging' && $level -le 30 ]]; then
    color="#f7768e"
fi

icon=0
if [[ $level -ge 99 ]]; then
    icon=9
elif [[ $level -ge 90 ]]; then
    icon=8
elif [[ $level -ge 75 ]]; then
    icon=6
elif [[ $level -ge 50 ]]; then
    icon=4
elif [[ $level -ge 25 ]]; then
    icon=2
else
    icon=0
fi

fg_color=""
if [[ -n $color ]]; then
    fg_color="^c$color^"
fi

echo "$fg_color${icons[$icon]} $level%^d^"
