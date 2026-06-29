#!/bin/bash
# Brightness Menu
# ~/.local/bin/brightness-menu.sh

MENU="rofi -dmenu -i -p Brightness -theme ~/.config/rofi/quick-settings.rasi"

# Get current brightness (0-100)
CURRENT=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

CHOICES="
☀  100%
☀  80%
☀  60%
☀  40%
☀  20%
☀  10%
☀  5%
☀  1%
--- 
󰃠  +10%
󰃞  -10%
--- 
Current: ${CURRENT}%"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *100%*) brightnessctl set 100% ;;
    *80%*) brightnessctl set 80% ;;
    *60%*) brightnessctl set 60% ;;
    *40%*) brightnessctl set 40% ;;
    *20%*) brightnessctl set 20% ;;
    *10%*) brightnessctl set 10% ;;
    *5%*) brightnessctl set 5% ;;
    *1%*) brightnessctl set 1% ;;
    *+10%*) brightnessctl set +10% ;;
    *-10%*) brightnessctl set 10%- ;;
esac