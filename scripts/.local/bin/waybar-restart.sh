#!/bin/bash
# Waybar restart script with style detection

STYLE_NORMAL="/home/anwar/.config/waybar/style.css"
STYLE_FOCUS="/home/anwar/.config/waybar/style-focus.css"
CONFIG="/home/anwar/.config/waybar/config.jsonc"

# Check if focus mode is active
if [[ -f /tmp/hypr-focus-mode ]]; then
    STYLE="$STYLE_FOCUS"
else
    STYLE="$STYLE_NORMAL"
fi

# Kill existing waybar
killall waybar 2>/dev/null
sleep 0.3

# Start waybar
waybar -c "$CONFIG" -s "$STYLE" &