#!/usr/bin/env bash

option1="	Waybar Theme"
option2="	GTK Theme"
option3="	QT Theme"
option4="	Wallpaper"

options="$option1\n$option2\n$option3\n$option4"

choice=$(echo -e "$options" | fuzzel -d -p "Choose Desktop Theme") 

case $choice in
	"$option1")
		themeswitcher.sh ;;
	"$option2")
		nwg-look ;;
	"$option3")
		qt6ct ;;
	"$option4")
		waypaper ;;
esac
