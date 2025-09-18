#!/bin/sh

# set colour to red if above 75%
free -h | awk '/^Mem/{
    printf("󰍛 ");
    if ($3 > 0.75 * $2) printf("^c#f7768e^");
    print $3" / "$2"^d^"
}' | sed s/i//g
