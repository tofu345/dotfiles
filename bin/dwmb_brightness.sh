#!/bin/sh

brightnessctl -m | awk 'BEGIN { FS = "," } {
    split($4, val, "%") # current brightness

    if (val[1] > 66)
        printf "^c#f0c674^󰃠"
    else if (val[1] > 33)
        printf "^c#d1ac64^󰃟"
    else
        printf "^c#ad8f53^󰃞"

    print " " $4 "^d^"
}'
