#!/usr/bin/bash

# Prevent duplicate waybar launches (lock)
exec 200>/tmp/waybar.lock
flock -n 200 || exit 0

# Quit all running waybar instances
killall waybar || true
pkill waybar || true
sleep 0.5

# Set default theme
themestyle="/colour-top"

# Get current theme information from .cache/.themestyle.sh
if [ -f ~/.cache/.themestyle.sh ]; then
	themestyle=$(cat ~/.cache/.themestyle.sh)
else
	touch ~/.cache/.themestyle.sh
	echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo $arrThemes

if [ ! -f ~/.config/waybar/themes$arrThemes/style.css ]; then
	themestyle="/colour-top"
fi

# Load waybar config
cfg_file="config"
css_file="style.css"
waybar -c ~/.config/waybar/themes$arrThemes/$cfg_file -s ~/.config/waybar/themes$arrThemes/$css_file &

# Unlock waybar launch on exit
flock -u 200
exec 200>&-
