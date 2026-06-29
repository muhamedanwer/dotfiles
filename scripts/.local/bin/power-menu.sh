#!/bin/bash
# Power Menu - Rofi-based power control
# ~/.local/bin/power-menu.sh

MENU="rofi -dmenu -i -p Power -theme ~/.config/rofi/power-menu.rasi"

CHOICES="
󰐥  Shutdown
󰜉  Reboot
󰤄  Suspend
󰒲  Hibernate
󰌾  Lock
󰍃  Logout
"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *Shutdown*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Suspend*) systemctl suspend ;;
    *Hibernate*) systemctl hibernate ;;
    *Lock*) swaylock ;;
    *Logout*) hyprctl dispatch exit ;;
esac