#!/bin/sh

option1="  Entire Desktop"
option2="  Capture Launcher"
option3="  Flameshot GUI"
option4="  Configure"

options="$option1\n$option2\n$option3\n$option4"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/screenshot.rasi -i -no-show-icons -l 4 -width 30) 

case $choice in
	$option1)
		sleep 1 && flameshot full ;;
	$option2)
		flameshot launcher ;;
	$option3)
		flameshot gui ;;
	$option4)
		flameshot config ;;
esac
