#!/usr/bin/bash

option1="	Font search"
option2="	Convert to jpg"
option3="󰙴	Merge images"
option4="	Archive extractor"
option5="	Color picker"
option6="	User apps"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	"$option1")
		$TERMINAL --class floating -e fontsearch.sh ;;
	"$option2")
		$TERMINAL --class floating -e convert-to-jpg.sh ;;
	"$option3")
		$TERMINAL --class floating -e merge_img.sh ;;
	"$option4")
		$TERMINAL --class floating -e extract.sh ;;
	"$option5")
		$TERMINAL --class colorpicker.sh -e colorpicker.sh ;;
	"$option6")
		$TERMINAL --class floating -e userapps.sh ;;
esac
