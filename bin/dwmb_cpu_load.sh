#!/bin/sh

cat /proc/loadavg | awk '{
    if ($1 > 8) printf("^c#f7768e^");
    else if ($1 > 5) printf("^c#e0af68^");
    print "󰖡 " $1 "^d^"
}'
