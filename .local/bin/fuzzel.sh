#!/usr/bin/env bash

. "${HOME}/.cache/wal/colors.sh"
b=$(echo "$color7"ff | sed 's/#//')
t=$(echo "$color0"ff | sed 's/#//')
m=$(echo "$color3"ff | sed 's/#//')
s=$(echo "$color1"ff | sed 's/#//')
S=$(echo "$color7"ff | sed 's/#//')
M=$(echo "$color3"ff | sed 's/#//')
C=$(echo "$color1"ff | sed 's/#//')

cat > ~/.config/fuzzel/wal_fuzzel.ini<< EOF
[colors]
background=$b
text=$t
match=$m
selection=$s
selection-text=$S
selection-match=$M
border=$C
EOF
