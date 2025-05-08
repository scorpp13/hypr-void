#!/usr/bin/env bash

check_and_start() {
	if ! pgrep -x "$1" >/dev/null; then
		echo "Starting $1..."
		sleep 1 && $2 &
	else
		echo "$1 is already running"
	fi
}

check_and_start "pipewire" "/usr/bin/pipewire"
