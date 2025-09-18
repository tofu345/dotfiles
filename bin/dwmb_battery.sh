#!/usr/bin/env bash

# Originally By: Jake@Linux https://gitlab.com/jped/scripts/-/blob/main/batt.sh?ref_type=heads

batstat="$(cat /sys/class/power_supply/BAT0/status)"
battery="$(cat /sys/class/power_supply/BAT0/capacity)"
if [[ $batstat != 'Discharging' ]] && [[ $battery -ge 99 ]]; then
    batstat="^c#7aa2f7^󰁹"
elif [[ $batstat != 'Discharging' ]] && [[ $battery -ge 75 ]]; then
    batstat="^c#7aa2f7^󰂁"
elif [[ $batstat != 'Discharging' ]] && [[ $battery -ge 50 ]]; then
    batstat="^c#7aa2f7^󰁾"
elif [[ $batstat != 'Discharging' ]] && [[ $battery -ge 25 ]]; then
    batstat="^c#7aa2f7^󰁼"
elif [[ $batstat != 'Discharging' ]] && [[ $battery -ge 1 ]]; then
    batstat="^c#7aa2f7^󰁺"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 5 ]]; then
    batstat="^c#f7768e^󰁺"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 25 ]]; then
    batstat="^c#f7768e^󰁼"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 50 ]]; then
    batstat="󰁾"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 75 ]]; then
    batstat="󰂀"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 97 ]]; then
    batstat="󰂂"
elif [[ $batstat = 'Discharging' ]] && [[ $battery -le 100 ]]; then
    batstat="󰁹"
fi

echo "$batstat $battery%^d^"
