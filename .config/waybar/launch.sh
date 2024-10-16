#!/bin/bash

# Check if waybar-disabled file exists
if [ -f $HOME/.cache/waybar-disabled ] ;then 
    pkill waybar
    exit 1 
fi

# Quit all running waybar instances
pkill waybar
sleep 0.2

# Default theme: /THEMEFOLDER;/VARIATION
themestyle="/myset;/myset/mixed"

# Get current theme information from .cache/.themestyle.sh
if [ -f ~/.cache/.themestyle.sh ]; then
    themestyle=$(cat ~/.cache/.themestyle.sh)
else
    touch ~/.cache/.themestyle.sh
    echo "$themestyle" > ~/.cache/.themestyle.sh
fi

IFS=';' read -ra arrThemes <<< "$themestyle"
echo ${arrThemes[0]}

if [ ! -f ~/.config/waybar/themes${arrThemes[1]}/style.css ]; then
    themestyle="/myset;/myset/mixed"
fi

# Loading the configuration
cfg_file="config"
css_file="style.css"
waybar -c ~/.config/waybar/themes${arrThemes[0]}/$cfg_file -s ~/.config/waybar/themes${arrThemes[1]}/$css_file &
