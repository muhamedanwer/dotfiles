#!/bin/bash
# Gamma Menu
# ~/.local/bin/gamma-menu.sh

MENU="rofi -dmenu -i -p Gamma -theme ~/.config/rofi/quick-settings.rasi"

CHOICES="
󰈈  Reset (1.0)
󰈈  Warm (0.9, 0.8, 0.7)
󰈈  Cool (1.0, 1.0, 1.1)
󰈈  Red Boost (1.1, 1.0, 0.9)
󰈈  Green Boost (1.0, 1.1, 0.9)
󰈈  Blue Boost (0.9, 1.0, 1.1)
--- 
󰈈  Custom..."

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *Reset*) hyprctl hyprsunset gamma 1.0:1.0:1.0 ;;
    *Warm*) hyprctl hyprsunset gamma 0.9:0.8:0.7 ;;
    *Cool*) hyprctl hyprsunset gamma 1.0:1.0:1.1 ;;
    *Red*) hyprctl hyprsunset gamma 1.1:1.0:0.9 ;;
    *Green*) hyprctl hyprsunset gamma 1.0:1.1:0.9 ;;
    *Blue*) hyprctl hyprsunset gamma 0.9:1.0:1.1 ;;
    *Custom*)
        custom=$(rofi -dmenu -p "Gamma (r:g:b)" -theme ~/.config/rofi/quick-settings.rasi)
        [[ -n "$custom" ]] && hyprctl hyprsunset gamma "$custom"
        ;;
esac