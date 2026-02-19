#!/bin/sh

if type nmcli &>/dev/null ; then
	device=$(nmcli -t -f DEVICE,TYPE device | grep wifi | cut -d: -f1 | head -n 1)
	nmcli | grep "${device}" -m 1 | awk '{
		if ($2 == "connected") {
			split($0, info, " connected to ")
			print "^c#9ece6a^󰤨 " info[2] "^d^"
		} else print "^c#f7768e^󰀝 Disconnected^d^"
	}'
else
	data=$(iwctl station wlan0 show)
	state=$(echo "${data}" | grep State)

	connected_regex="^ *State *connected"
	if [[ $state =~ $connected_regex ]]; then
		provider=$(echo "${data}" | awk '/Connected network/{ print $3 }')
		echo "^c#9ece6a^󰤨 ${provider}^d^"
	else
		echo "^c#f7768e^󰀝 Disconnected^d^"
	fi
fi
