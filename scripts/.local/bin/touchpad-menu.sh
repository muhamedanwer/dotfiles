#!/bin/bash
# Touchpad Menu
# ~/.local/bin/touchpad-menu.sh

MENU="rofi -dmenu -i -p Touchpad -theme ~/.config/rofi/quick-settings.rasi"

# Get current state
NATURAL=$(hyprctl getoption input:touchpad:natural_scroll -j | jq -r '.int')
TAP=$(hyprctl getoption input:touchpad:tap_to_click -j | jq -r '.int')
DWT=$(hyprctl getoption input:touchpad:disable_while_typing -j | jq -r '.int')

NATURAL_STR=$([[ $NATURAL -eq 1 ]] && echo "✓" || echo "✗")
TAP_STR=$([[ $TAP -eq 1 ]] && echo "✓" || echo "✗")
DWT_STR=$([[ $DWT -eq 1 ]] && echo "✓" || echo "✗")

CHOICES="
☚  Natural Scroll [$NATURAL_STR]
☚  Tap to Click [$TAP_STR]
☚  Disable While Typing [$DWT_STR]
---
☚  Sensitivity: Low
☚  Sensitivity: Medium
☚  Sensitivity: High
---
☚  Disable Touchpad
☚  Enable Touchpad
"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *Natural*)
        NEW=$([[ $NATURAL -eq 1 ]] && echo 0 || echo 1)
        hyprctl keyword input:touchpad:natural_scroll $NEW
        ;;
    *Tap*)
        NEW=$([[ $TAP -eq 1 ]] && echo 0 || echo 1)
        hyprctl keyword input:touchpad:tap_to_click $NEW
        ;;
    *Disable\ While*)
        NEW=$([[ $DWT -eq 1 ]] && echo 0 || echo 1)
        hyprctl keyword input:touchpad:disable_while_typing $NEW
        ;;
    *Low*) hyprctl keyword input:sensitivity 0.3 ;;
    *Medium*) hyprctl keyword input:sensitivity 0.5 ;;
    *High*) hyprctl keyword input:sensitivity 0.8 ;;
    *Disable*) hyprctl keyword input:touchpad:disable_on_keyboard 1 ;;
    *Enable*) hyprctl keyword input:touchpad:disable_on_keyboard 0 ;;
esac