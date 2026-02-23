#!/usr/bin/bash

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option1="Selected area"
option2="Fullscreen (delay 5 sec)"
option3="Current display (delay 5 sec)"

options="$option1\n$option2\n$option3"

choice=$(echo -e "$options" | fuzzel -d --anchor center -p "Take Screenshot")

case $choice in
	"$option1")
		grim -g "$(slurp)" "$DIR$NAME"
		xclip -selection clipboard -t image/png -i "$DIR$NAME"
		notify-send "Screenshot created" "Mode: Selected area"
		swappy -f "$DIR$NAME"
		;;
	"$option1")
		sleep 5
		grim "$DIR$NAME"
		xclip -selection clipboard -t image/png -i "$DIR$NAME"
		notify-send "Screenshot created" "Mode: Fullscreen"
		swappy -f "$DIR$NAME"
		;;
	"$option3")
		sleep 5
		monitor="$(hyprctl monitors | awk '/Monitor/{monitor=$2} /focused: yes/{print monitor; exit}')"
		grim -o "$monitor" "$DIR$NAME"
		xclip -selection clipboard -t image/png -i "$DIR$NAME"
		notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
		swappy -f "$DIR$NAME"
		;;
esac
