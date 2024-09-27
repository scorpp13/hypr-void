#!/bin/bash
#   ___ _ _      _  _ _    _   
#  / __| (_)_ __| || (_)__| |_ 
# | (__| | | '_ \ __ | (_-<  _|
#  \___|_|_| .__/_||_|_/__/\__|
#          |_|                 

case $1 in
    d) cliphist list | fuzzel -d| cliphist delete
       ;;

    w) if [ `echo -e "Clear\nCancel" | fuzzel -d` == "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | fuzzel -d| cliphist decode | wl-copy
       ;;
esac
