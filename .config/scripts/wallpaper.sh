#!/bin/bash
# __      __    _ _                          
# \ \    / /_ _| | |_ __  __ _ _ __  ___ _ _ 
#  \ \/\/ / _` | | | '_ \/ _` | '_ \/ -_) '_|
#   \_/\_/\__,_|_|_| .__/\__,_| .__/\___|_|  
#                  |_|        |_|            

case $1 in

	# Load wallpaper from .cache of last session 
    "init")
        if [ -f ~/.cache/current_wallpaper.jpg ]; then
            wal -i ~/.cache/current_wallpaper.jpg
        else
            wal -i ~/.config/wallpapers/
        fi
    ;;

	# Select wallpaper
    "select")
        selected=$(ls -1 ~/.config/wallpapers | grep "jpg" | fuzzel -d)
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -i ~/.config/wallpapers/$selected
    ;;

	# Random wallpaper 
    *)
        wal -i ~/.config/wallpapers/
    ;;

esac

# Load current pywal color scheme
source "$HOME/.cache/wal/colors.sh"
echo "Wallpaper: $wallpaper"

# Copy selected wallpaper into .cache folder
cp $wallpaper ~/.cache/current_wallpaper.jpg

# get wallpaper image name
newwall=$(echo $wallpaper | sed "s|$HOME/.config/wallpapers/||g")

# Reload waybar with new colors
~/.config/waybar/launch.sh

# Set the new wallpaper
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

swww img $wallpaper \
    --transition-bezier .43,1.19,1,.4 \
    --transition-fps=60 \
    --transition-type=$transition_type \
    --transition-duration=0.7 \
    --transition-pos "$( hyprctl cursorpos )"

# Send notification
sleep 1
notify-send "Colors and Wallpaper updated" "with image $newwall"

echo "DONE"
