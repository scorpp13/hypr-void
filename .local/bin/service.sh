#!/usr/bin/bash

sudo vsv
echo ""
if gum confirm "Show Help?"; then
	vsv --help
		elif [ $? -eq 130 ]; then
			exit 130
		else
			exit;
fi
echo ""
echo ""
if gum confirm "Stayin' Shell?"; then
	check_and_start() {
		if ! pgrep -x "$1" >/dev/null; then
			$1
		else
			$SHELL
		fi
	}
	check_and_start "/usr/bin/fish"

	elif [ $? -eq 130 ]; then
		exit 130
	else
		exit;
fi
