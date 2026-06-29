#!/bin/bash
# Quick Settings Menu - Rofi-based system control
# ~/.local/bin/quick-settings.sh

MENU="rofi -dmenu -i -p Settings -theme ~/.config/rofi/quick-settings.rasi"

CHOICES="
󰍹  Display
󰂯  Bluetooth
󰖩  Network
󰝚  Audio
󰒒  Power
󰌌  Notifications
󰛨  Night Light
󰝟  Keyboard
󰍜  Touchpad
󰸌  Screen Record
󰄄  Screenshot
󰅈  Color Picker
󰒓  Focus Mode
"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *Display*)
        ~/.local/bin/display-menu.sh
        ;;
    *Bluetooth*)
        blueman-manager &
        ;;
    *Network*)
        nm-connection-editor &
        ;;
    *Audio*)
        pavucontrol &
        ;;
    *Power*)
        ~/.local/bin/power-menu.sh
        ;;
    *Notifications*)
        makoctl set-mode default
        notify-send "Notifications" "Restored to default mode"
        ;;
    *Night\ Light*)
        ~/.local/bin/nightlight-toggle.sh
        ;;
    *Keyboard*)
        ~/.local/bin/keyboard-menu.sh
        ;;
    *Touchpad*)
        ~/.local/bin/touchpad-menu.sh
        ;;
    *Screen\ Record*)
        wf-recorder -g "$(slurp)" -f ~/Videos/recording-$(date +%s).mp4
        ;;
    *Screenshot*)
        grim -g "$(slurp)" - | swappy -f -
        ;;
    *Color\ Picker*)
        ~/.local/bin/color-picker.sh
        ;;
    *Focus\ Mode*)
        ~/.config/hypr/scripts/focus-mode.sh
        ;;
esac