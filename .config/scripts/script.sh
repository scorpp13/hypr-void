#!/bin/bash

option1="  Convert to gif"
option2="  Convert to jpg"
option3="  Merge images"
option4="  Archive extractor"
option5="  Font search"
option6="  Package manager"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	$option1)
		alacritty -e $SHELL -c "convert-to-gif.sh && sleep 1" ;;
	$option2)
		alacritty -e $SHELL -c "convert-to-jpg.sh && sleep 1" ;;
	$option3)
		alacritty -e $SHELL -c "merge_img.sh && sleep 1" ;;
	$option4)
		alacritty -e $SHELL -c "extract.sh && sleep 1" ;;
	$option5)
		alacritty --hold -e fontsearch.sh ;;
	$option6)
		alacritty -e xbpspkg.sh ;;
esac
