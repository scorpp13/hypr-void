#!/usr/bin/env bash

for x in /var/cache/xbps/*.xbps; do 
  xbps-query $(xbps-uhelper binpkgver "$x") 1>/dev/null 2>&1
  if [ $? == 2 ]; then 
    echo $x
  fi
done
