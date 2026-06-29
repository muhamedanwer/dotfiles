#!/bin/bash
# Display Menu - Rofi-based display control
# ~/.local/bin/display-menu.sh

MENU="rofi -dmenu -i -p Display -theme ~/.config/rofi/quick-settings.rasi"

# Get connected monitors
MONITORS=$(hyprctl monitors -j | jq -r '.[] | "\(.name) \(.width)x\(.height)@\(.refreshRate)Hz"')

CHOICES="
󰍹  Mirror Displays
󰍺  Extend Displays
󰁫  Primary Only
󰁪  Secondary Only
--- 
$MONITORS
--- 
󰛨  Night Light Toggle
󰃠  Brightness
󰈈  Gamma
"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *Mirror*)
        hyprctl keyword monitor "eDP-1,preferred,auto,1" "HDMI-A-1,preferred,auto,1,mirror,eDP-1"
        ;;
    *Extend*)
        hyprctl keyword monitor "eDP-1,preferred,auto,1" "HDMI-A-1,preferred,auto,1,right,eDP-1"
        ;;
    *Primary*)
        hyprctl keyword monitor "eDP-1,preferred,auto,1" "HDMI-A-1,disable"
        ;;
    *Secondary*)
        hyprctl keyword monitor "eDP-1,disable" "HDMI-A-1,preferred,auto,1"
        ;;
    *Night\ Light*)
        ~/.local/bin/nightlight-toggle.sh
        ;;
    *Brightness*)
        ~/.local/bin/brightness-menu.sh
        ;;
    *Gamma*)
        ~/.local/bin/gamma-menu.sh
        ;;
    *)
        # Monitor selected - toggle
        MON_NAME=$(echo "$selection" | awk '{print $1}')
        if [[ -n "$MON_NAME" && "$MON_NAME" != "---" ]]; then
            hyprctl dispatch focusmonitor "$MON_NAME"
        fi
        ;;
esac