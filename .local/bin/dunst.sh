#!/usr/bin/bash

config=$HOME/.config/dunst/dunstrc
head -n -2 "$config" > dunstrc_

if grep -q "top" ~/.cache/.themestyle.sh ; then
		 origin="top-center"
	elif grep -q "bottom" ~/.cache/.themestyle.sh ; then
		 origin="bottom-center"
	else origin="top-center"
fi

echo -e "[global]\norigin = $origin" >> dunstrc_
mv dunstrc_ "$config"

pkill dunst
sleep 0.2
dunst
