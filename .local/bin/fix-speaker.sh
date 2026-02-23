#!/usr/bin/env bash

CARD_INFO=$(pactl list cards | awk '
/^Card #/ { if (++c > 1) exit }
{ print }
')

CARD_NAME="$(printf '%s\n' "$CARD_INFO" | awk -F': ' '/^\s*Name:/ { print $2 }')"

ACTIVE_PROFILE="$(printf '%s\n' "$CARD_INFO" \
    | awk -F': ' '/^\s*Active Profile:/ { print $2 }')"

if [[ "$ACTIVE_PROFILE" == "off" ]]; then
    echo "Warning: The current active profile is set to 'off'."
    echo "Please select a valid profile through 'pavucontrol > Configuration' before running this script."
    exit 1
fi

# need to toggle card-profile once to reset the audio stack properly
pactl set-card-profile "$CARD_NAME" off
pactl set-card-profile "$CARD_NAME" "$ACTIVE_PROFILE"
