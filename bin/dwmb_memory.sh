#!/bin/sh

free -h | awk '/^Mem/{ print " " $3 "/" $2 "^d^" }' | sed s/i//g
