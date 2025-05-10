#!/usr/bin/env bash

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
	fish
elif [ $? -eq 130 ]; then
	exit 130
else
	exit;
fi
