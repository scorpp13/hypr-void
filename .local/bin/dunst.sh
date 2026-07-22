#!/usr/bin/bash

config=$HOME/.config/dunst/dunstrc

icon=$(cat ${HOME}/.config/gtk-3.0/settings.ini | \
grep "gtk-icon-theme-name" | \
sed 's/gtk-icon-theme-name=//')

font=$(cat ${HOME}/.config/gtk-3.0/settings.ini | \
grep "gtk-font-name" | \
sed 's/gtk-font-name=//')

if grep -q "top" ~/.cache/.themestyle.sh ; then
		 origin="top-right"
	elif grep -q "bottom" ~/.cache/.themestyle.sh ; then
		 origin="bottom-right"
	else origin="top-right"
fi

head -n -4 "$config" > dunstrc_
echo -e "[global]\norigin = $origin\nfont = $font\nicon_theme = $icon" >> dunstrc_
mv dunstrc_ "$config"
dunstctl reload
