#!/bin/bash
#   ___ _ _      _  _ _    _   
#  / __| (_)_ __| || (_)__| |_ 
# | (__| | | '_ \ __ | (_-<  _|
#  \___|_|_| .__/_||_|_/__/\__|
#          |_|                 

case $1 in
    d) cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-cliphist.rasi | cliphist delete
       ;;

    w) if [ `echo -e "Clear\nCancel" | rofi -dmenu -config ~/.config/rofi/config-short.rasi` == "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | rofi -dmenu -replace -config ~/.config/rofi/config-cliphist.rasi | cliphist decode | wl-copy
       ;;
esac
