#!/usr/bin/env bash   

threshhold_zero=-1
threshhold_green=0
threshhold_yellow=20
threshhold_red=100

# Calculate available updates
updates=$(xbps-install --memory-sync --dry-run --update | grep -Fe update -e install | wc -l)

# Output .json format for Waybar Module custom-updates
	css_class="zero"
if [ "$updates" -gt $threshhold_green ]; then
	css_class="green"
fi
if [ "$updates" -gt $threshhold_yellow ]; then
	css_class="yellow"
fi
if [ "$updates" -gt $threshhold_red ]; then
	css_class="red"
fi
if [ "$updates" -gt $threshhold_zero ]; then
	printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
	printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "zero"}'
fi
