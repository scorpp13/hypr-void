#!/usr/bin/bash

text=$(curl ru.wttr.in/$1?format=1)

if [[ $? == 0 ]]
then
	text=$(echo "$text" | sed -E "s/\s+/ /g")
	tooltip=$(curl ru.wttr.in/$1?format=%l:+%C+%c+%t+%w+%m)
	if [[ $? == 0 ]]
	then
		tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
		echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
		exit
	fi
fi

echo "{\"text\":\"Service Unavailable\", \"tooltip\":\"Service Unavailable\"}
