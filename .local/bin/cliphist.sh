#!/usr/bin/bash

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
