#!/bin/bash
#  _            ___ _         _ _              
# | |_____ _  _| _ |_)_ _  __| (_)_ _  __ _ ___
# | / / -_) || | _ \ | ' \/ _` | | ' \/ _` (_-<
# |_\_\___|\_, |___/_|_||_\__,_|_|_||_\__, /__/
#          |__/                       |___/    
#
# Define keybindings.conf location
config_file=~/.config/hypr/conf/keybindings.conf

# Parse keybindings
keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')

# Show keybindings in rofi
#rofi -dmenu -replace -p "Keybinds" -config ~/.config/rofi/config-compact.rasi <<< "$keybinds"
fuzzel -d <<< "$keybinds"
