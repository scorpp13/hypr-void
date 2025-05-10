#!/usr/bin/env bash

# Path to theme folder
themes_path="$HOME/.config/waybar/themes"

# Init database
listThemes=""
listNames=""

# Read themes list
sleep 0.2
options=$(find $themes_path -type d)
for value in $options
do
	if [ ! $value == "$themes_path" ]; then
		if [ $(find $value -type d | wc -l) = 1 ]; then
			result=$(echo $value | sed "s#$HOME/.config/waybar/themes/#/#g")
			IFS='/' read -ra arrThemes <<< "$result"
			listThemes[${#listThemes[@]}]="$arrThemes$result"
			if [ -f $themes_path$result/config.sh ]; then
				source $themes_path$result/config.sh
				listNames+="$theme_name\n"
			else
				listNames+="$arrThemes$result\n"
			fi
		fi
	fi
done

# Call fuzzel for make a choice 
listNames=${listNames::-2}
choice=$(echo -e "$listNames" | fuzzel -d --index \
	-p "Switch Waybar Theme" \
	-f "Fira Code:weight=regular:size=12" \
	-t 990000ff)

# Set new theme
if [ "$choice" ]; then
	echo "Loading waybar theme..."
	echo "${listThemes[$choice+1]}" > ~/.cache/.themestyle.sh
	~/.config/waybar/launch.sh
fi
