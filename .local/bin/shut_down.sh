#!/usr/bin/bash
set -euo pipefail

timeout=10
start_time=$(date +%s)
client_pids=$(hyprctl clients -j | jq -r '.[].pid')

# If no clients, nothing to do
[ -n "${client_pids}" ] || exit 0

# Request termination
for pid in $client_pids; do
	kill -15 "$pid" 2>/dev/null || true
done

# Wait until they are all gone or timeout hits
while :; do
	all_gone=true
	for pid in $client_pids; do
		if kill -0 "$pid" 2>/dev/null; then
			all_gone=false
			break
		fi
	done

	$all_gone && break

	now=$(date +%s)
	elapsed=$(( now - start_time ))
	[ "$elapsed" -ge "$timeout" ] && break

	sleep 0.1
done

# Escalate if any are still alive
for pid in $client_pids; do
	if kill -0 "$pid" 2>/dev/null; then
		kill -9 "$pid" 2>/dev/null || true
	fi
done
