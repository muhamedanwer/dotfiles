#!/bin/bash
# Night Light Toggle
# ~/.local/bin/nightlight-toggle.sh

STATE_FILE="/tmp/nightlight-state"

if [[ -f "$STATE_FILE" ]]; then
    # Disable night light
    hyprctl hyprsunset identity
    rm "$STATE_FILE"
    notify-send -u low "Night Light" "Disabled" -t 1500
else
    # Enable night light (warm 3500K)
    hyprctl hyprsunset temperature 3500
    touch "$STATE_FILE"
    notify-send -u low "Night Light" "Enabled (3500K)" -t 1500
fi