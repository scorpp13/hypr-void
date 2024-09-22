#!/bin/sh

# This script convert *.png images to *.jpg
DIR=$(gum file --directory $HOME)
INPUT=$(ls $DIR | gum choose --no-limit)
gum confirm "Convert selected images?" && \
gum spin --title "Converting..." -- sleep 1 && \
cd $DIR && mogrify -format jpg $INPUT
