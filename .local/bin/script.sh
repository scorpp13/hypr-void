#!/usr/bin/env bash

option1="	Calculator"
option2="	Font search"
option3="	Convert to jpg"
option4="󰙴	Merge images"
option5="	 Archive extractor"

options="$option1\n$option2\n$option3\n$option4\n$option5"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	"$option1")
		kitty --class floating -e qalc ;;
	"$option2")
		kitty --class floating -e fontsearch.sh ;;
	"$option3")
		kitty --class floating -e convert-to-jpg.sh ;;
	"$option4")
		kitty --class floating -e merge_img.sh ;;
	"$option5")
		kitty --class floating -e extract.sh ;;
esac
