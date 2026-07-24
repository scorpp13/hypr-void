#!/usr/bin/bash

. "${HOME}/.cache/wal/colors.sh"
frame_color='"'$foreground'"'
foreground='"'#ffffff'"'
background='"'$background'70"'

config=$HOME/.config/dunst/dunstrc

icon=$(cat ${HOME}/.config/gtk-3.0/settings.ini | \
grep "gtk-icon-theme-name" | \
sed 's/gtk-icon-theme-name=//')

font=$(cat ${HOME}/.config/gtk-3.0/settings.ini | \
grep "gtk-font-name" | \
sed 's/gtk-font-name=//' | \
tr -d '0-9') # grep -o '[^0-9]*') .. sed 's/[0-9]//g')

if grep -q "top" ~/.cache/.themestyle.sh ; then
		 origin="top-right"
	elif grep -q "bottom" ~/.cache/.themestyle.sh ; then
		 origin="bottom-right"
	else origin="top-right"
fi

head -n -6 "$config" > dunstrc_
echo -e "origin = $origin\nfont = "$font" 14\nicon_theme = $icon\nframe_color = $frame_color\nforeground = $foreground\nbackground = $background" >> dunstrc_
mv dunstrc_ "$config"
dunstctl reload
