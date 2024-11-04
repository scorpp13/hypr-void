#!/bin/bash

# Check if waybar-disabled file exists
if [ -f $HOME/.cache/waybar-disabled ] ;then
	pkill waybar
	exit 1 
fi

# Quit all running waybar instances
pkill waybar
sleep 0.2

# Set default theme
themestyle="/colored"

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
	themestyle="/colored"
fi

# Load waybar config
cfg_file="config"
css_file="style.css"
waybar -c ~/.config/waybar/themes/$cfg_file -s ~/.config/waybar/themes$arrThemes/$css_file &
