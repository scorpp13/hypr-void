#!/bin/sh

option1="   IPTV sport"
option2="󰄘  IPTV full"
option3="  MPV gui"
option4="  Music"

options="$option1\n$option2\n$option3\n$option4"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/mpv.rasi -i -no-show-icons -l 4 -width 30) 

case $choice in
	$option1)
		sleep 1 && mpv ~/Videos/iptv_sport.m3u ;;
	$option2)
		mpv ~/Videos/iptv_full.m3u ;;
	$option3)
		mpv --player-operation-mode=pseudo-gui --idle ;;
	$option4)
		mpv ~/Music/ ;;
esac
