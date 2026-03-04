#!/usr/bin/bash

config=$HOME/.config/dunst/dunstrc

if grep -q "top" ~/.cache/.themestyle.sh ; then
		 origin="top-right"
	elif grep -q "bottom" ~/.cache/.themestyle.sh ; then
		 origin="bottom-right"
	else origin="top-right"
fi

head -n -2 "$config" > dunstrc_
echo -e "[global]\norigin = $origin" >> dunstrc_
mv dunstrc_ "$config"
dunstctl reload
