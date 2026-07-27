#!/usr/bin/bash

case $1 in
	d)	cliphist list | fuzzel -d --with-nth 2 | cliphist delete
	;;

	w)	if [ "$(echo -e 'Wipe clipboard\nCancel' | fuzzel -d)" == 'Wipe clipboard' ] ; then
		cliphist wipe
		fi
	;;

   *)	cliphist list | fuzzel -d --with-nth 2 | cliphist decode | wl-copy
   ;;
esac
