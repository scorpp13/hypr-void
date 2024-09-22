#!/bin/bash
#  _____ _                  ___        _ _      _    
# |_   _| |_  ___ _ __  ___/ __|_ __ _(_) |_ __| |_  
#   | | | ' \/ -_) '  \/ -_)__ \ V  V / |  _/ _| ' \ 
#   |_| |_||_\___|_|_|_\___|___/\_/\_/|_|\__\__|_||_|
#                                                    

# Default folder
themes_path="$HOME/.config/waybar/themes"

# Init database
listThemes=""
listNames=""

# Read folder
sleep 0.2
options=$(find $themes_path -maxdepth 2 -type d)
for value in $options
do
    if [ ! $value == "$themes_path" ]; then
        if [ $(find $value -maxdepth 1 -type d | wc -l) = 1 ]; then
            result=$(echo $value | sed "s#$HOME/.config/waybar/themes/#/#g")
            IFS='/' read -ra arrThemes <<< "$result"
            listThemes[${#listThemes[@]}]="/${arrThemes[1]};$result"
            if [ -f $themes_path$result/config.sh ]; then
                source $themes_path$result/config.sh
                listNames+="$theme_name\n"
            else
                listNames+="/${arrThemes[1]};$result\n"
            fi
        fi
    fi
done

# Show rofi dialog
listNames=${listNames::-2}
#choice=$(echo -e "$listNames" | rofi -dmenu -replace -config ~/.config/rofi/config-theme.rasi -no-show-icons -width 30 -p "Themes" -format i) 
choice=$(echo -e "$listNames" | fuzzel -d --index -format i)

# Set new theme by writing the theme information to ~/.cache/.themestyle.sh
if [ "$choice" ]; then
    echo "Loading waybar theme..."
    echo "${listThemes[$choice+1]}" > ~/.cache/.themestyle.sh
    ~/.config/waybar/launch.sh
fi
