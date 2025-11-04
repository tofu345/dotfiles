#!/bin/sh

# numbers seperated by tabs.
cat <<EOF | xmenu
[]=  Tiled Layout	0
[M]  Monocle Layout	1
><>  Floating Layout	2
EOF

# |M|  Centeredmaster	2
# TTT  Bstack	3
# HHH  Grid	4
# [@]  Spiral	5
# [\\] Dwindle	6
# H[]  Deck	7
# ===  Bstackhoriz	8
# ###  Nrowgrid	9
# ---  Horizgrid	10
# :::  Gaplessgrid	11
# >M>  Centeredfloatingmaster	12
