#!/bin/sh

# https://askubuntu.com/a/297978
vmstat 1 2 | tail -1 | awk '{
    $15 = 100 - $15
    if ($15 > 90) printf("^c#f7768e^")
    else if ($15 > 75) printf("^c#e0af68^");
    print " " $15 "%^d^"
}'
