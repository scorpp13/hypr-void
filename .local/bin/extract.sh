#!/bin/bash

DIR=$(gum file --directory $HOME)
INPUT=$(ls $DIR | gum choose --limit 1)
gum confirm "Extract selected file?" && \
gum spin --title "Extracting..." -- sleep 1 && cd $DIR
if [ -f $INPUT ] ; then
	case $INPUT in
		*.tar.bz2)	tar xjf $INPUT		;;
		*.tar.gz)	tar xzf $INPUT		;;
		*.bz2)		bunzip2 $INPUT		;;
		*.rar)		unrar x $INPUT		;;
		*.gz)		gunzip $INPUT		;;
		*.tar)		tar xf $INPUT		;;
		*.tar.xz)	tar xf $INPUT		;;
		*.tbz2)		tar xjf $INPUT		;;
		*.tgz)		tar xzf $INPUT		;;
		*.zip)		unzip $INPUT		;;
		*.Z)		uncompress $INPUT	;;
		*.7z)		7zz x $INPUT		;;
		*)	echo "'$INPUT' can't be extracted"	;;
	esac
		else
			echo "'$INPUT' isn't a valid archive file"
fi
