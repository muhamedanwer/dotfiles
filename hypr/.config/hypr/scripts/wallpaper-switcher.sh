#!/bin/bash
# Wallpaper switcher using rofi

CONFIG_FILE="$HOME/dotfiles/hypr/.config/hypr/wallpapers.conf"
source "$CONFIG_FILE"

# Build menu options
MENU=""
for wp in "${WALLPAPERS[@]}"; do
    NAME=$(basename "$wp")
    MENU+="$NAME|$wp\n"
done

# Show rofi menu
CHOICE=$(echo -e "$MENU" | rofi -dmenu -i -p "Wallpaper" -sep "|" -theme ~/.config/rofi/quick-input.rasi)

if [ -n "$CHOICE" ]; then
    # Find the full path
    for wp in "${WALLPAPERS[@]}"; do
        if [[ "$(basename "$wp")" == "$CHOICE" ]]; then
            hyprctl hyprpaper wallpaper "eDP-1,$wp"
            notify-send "Wallpaper changed" "$CHOICE"
            break
        fi
    done
fi