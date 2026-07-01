#!/usr/bin/bash

#config_file=~/.config/hypr/conf/keybindings.conf
#keybinds=$(grep -oP '(?<=bind = ).*' $config_file)
#keybinds=$(echo "$keybinds" | sed 's/$mainMod/SUPER/g'|  sed 's/,\([^,]*\)$/ = \1/' | sed 's/, exec//g' | sed 's/^,//g')
#fuzzel -d <<< "$keybinds"

hyprctl binds -j | jq -c '.[] | select(.description != "")' | awk '
BEGIN {
    # Define modifier bits based on libxkbcommon
    mod_map[64] = "SUPER"
    mod_map[8]  = "ALT"
    mod_map[4]  = "CTRL"
    mod_map[1]  = "SHIFT"
}
{
    # Extract values from jq JSON string
    match($0, /"modmask":([0-9]+)/, m)
    modmask = m[1]
    
    match($0, /"key":"([^"]+)"/, k)
    key = toupper(k[1])
    
    match($0, /"description":"([^"]+)"/, d)
    desc = d[1]

    # Reconstruct modifier names from mask
    mods = ""
    for (bit in mod_map) {
        if (and(modmask, bit)) {
            mods = (mods == "" ? mod_map[bit] : mods " + " mod_map[bit])
        }
    }

    # Format the key combination string
    if (mods != "" && key != "") {
        combo = mods " + " key
    } else {
        combo = (mods != "" ? mods : key)
    }

    # Output: Column 1 (Keys), Column 2 (Description)
    printf "%s\n>>> %s\0", combo, desc
}' | fuzzel --dmenu0 "Keybinds" --config=$HOME/.config/fuzzel/fuzzel_d.ini
