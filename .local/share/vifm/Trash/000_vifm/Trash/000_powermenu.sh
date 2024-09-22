#!/bin/sh

lock="~/.local/bin/lock.sh"

option1="  Lock"
option2="  Logout"
option3="  Reboot"
option4="  Power off"

options="$option1\n$option2\n$option3\n$option4"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/powermenu.rasi -i -no-show-icons -l 4 -width 30 -p "Powermenu") 

case $choice in
	$option1)
		~/.local/bin/lock.sh ;;
	$option2)
		qtile cmd-obj -o cmd -f shutdown ;;
	$option3)
		loginctl reboot ;;
	$option4)
		loginctl poweroff ;;
esac
