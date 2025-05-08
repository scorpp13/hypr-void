#!/usr/bin/env bash

option1="󱗄	Calculator"
option2="	Font search"
option3="	Convert to gif"
option4="	Convert to jpg"
option5="󰙴	Merge images"
option6="	 Archive extractor"
option7="	Package manager"

options="$option1\n$option2\n$option3\n$option4\n$option5\n$option6\n$option7"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	"$option1")
		alacritty -e qalc ;;
	"$option2")
		kitty --class floating "$SHELL" -c "fontsearch.sh" ;;
	"$option3")
		alacritty -e $SHELL -c "convert-to-gif.sh && sleep 1" ;;
	"$option4")
		alacritty -e $SHELL -c "convert-to-jpg.sh && sleep 1" ;;
	"$option5")
		alacritty -e $SHELL -c "merge_img.sh && sleep 1" ;;
	"$option6")
		alacritty -e $SHELL -c "extract.sh && sleep 1" ;;
	"$option7")
		alacritty -e xbpspkg.sh ;;
esac
