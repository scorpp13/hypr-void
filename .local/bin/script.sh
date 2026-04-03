#!/usr/bin/bash

option1="	Font search"
option2="	Convert to jpg"
option3="󰙴	Merge images"
option4="	 Archive extractor"
option5="	ColorPicker"

options="$option1\n$option2\n$option3\n$option4\n$option5"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	"$option1")
		kitty --class floating -e fontsearch.sh ;;
	"$option2")
		kitty --class floating -e convert-to-jpg.sh ;;
	"$option3")
		kitty --class floating -e merge_img.sh ;;
	"$option4")
		kitty --class floating -e extract.sh ;;
	"$option5")
		kitty --class colorpicker.sh -e colorpicker.sh ;;
esac
