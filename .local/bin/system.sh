#!/usr/bin/bash

option1="	Package manager"
option2="	Runit service manager"
option3="	 XBPS history and logs"

options="$option1\n$option2\n$option3"

choice=$(echo -e "$options" | fuzzel -d) 

case $choice in
	"$option1")
		$TERMINAL --class floating -e fuzzypkg ;;
	"$option2")
		$TERMINAL --class floating -e service.sh ;;
	"$option3")
		$TERMINAL --class floating -e xbps-hist.sh -l -c -f ;;
esac
