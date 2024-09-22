#!/bin/sh

option1="  Rofi themes"
option2="  Convert to gif"
option3="  Convert to jpg"
option4="  Merge images"
option5="  Archive extractor"
option6="  Font search"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/.config/rofi/script.rasi -i -no-show-icons -l 6 -width 30) 

case $choice in
	$option1)
		alacritty -e $SHELL -c "rtheme.sh && sleep 1" ;;
	$option2)
		alacritty -e $SHELL -c "convert-to-gif.sh && sleep 1" ;;
	$option3)
		alacritty -e $SHELL -c "convert-to-jpg.sh && sleep 1" ;;
	$option4)
		alacritty -e $SHELL -c "merge_img.sh && sleep 1" ;;
	$option5)
		alacritty -e $SHELL -c "extract.sh && sleep 1" ;;
	$option6)
		alacritty --hold -e fontsearch.sh ;;
esac
