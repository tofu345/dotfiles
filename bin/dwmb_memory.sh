#!/bin/sh

# red colour if memory usage above 75%
free -h | awk '/^Mem/{
    if ($3 > 0.75 * $2) printf("^c#f7768e^");
    printf(" ");
    print $3 "/" $2 "^d^"
}' | sed s/i//g
