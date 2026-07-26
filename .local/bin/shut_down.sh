#!/usr/bin/bash

timeout=10
start_time=$(date +%s)
client_pids=$(hyprctl clients -j | jq -r '.[] | .pid')

for pid in $client_pids; do
	kill -15 $pid
done

for pid in $client_pids; do
	while kill -0 $pid 2>/dev/null; do
		current_time=$(date +%s)
		elapsed_time=$((current_time - start_time))
			if [ $elapsed_time -ge $timeout ]; then
				return 0
			fi
		sleep 1
	done
done
