#!/usr/bin/env bash

config_file=~/.config/hypr/conf/keybindings.conf
keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
fuzzel -d <<< "$keybinds"
