#!/bin/sh

data=$(iwctl station wlan0 show)
state=$(echo "${data}" | grep State)

connected_regex="^ *State *connected"
if [[ $state =~ $connected_regex ]]; then
	provider=$(echo "${data}" | awk '/Connected network/{ print $3 }')
	echo "^c#9ece6a^󰤨 ${provider}^d^" 
else
	echo "^c#f7768e^󰀝 Disconnected^d^"
fi
