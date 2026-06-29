#!/bin/bash
# Keyboard Menu
# ~/.local/bin/keyboard-menu.sh

MENU="rofi -dmenu -i -p Keyboard -theme ~/.config/rofi/quick-settings.rasi"

CHOICES="
⌨  Layout: US
⌨  Layout: US Intl
⌨  Layout: Dvorak
⌨  Layout: Colemak
---
⌨  Repeat Rate: Fast
⌨  Repeat Rate: Normal
⌨  Repeat Rate: Slow
---
⌨  Caps → Escape
⌨  Caps → Ctrl
⌨  Caps → Caps
---
⌨  NumLock On
⌨  NumLock Off
"

selection=$(echo "$CHOICES" | $MENU)

case "$selection" in
    *US\ Intl*) hyprctl keyword input:kb_layout "us,us" && hyprctl keyword input:kb_variant ",intl" ;;
    *Dvorak*) hyprctl keyword input:kb_layout "us" && hyprctl keyword input:kb_variant "dvorak" ;;
    *Colemak*) hyprctl keyword input:kb_layout "us" && hyprctl keyword input:kb_variant "colemak" ;;
    *US*) hyprctl keyword input:kb_layout "us" && hyprctl keyword input:kb_variant "" ;;
    *Fast*) hyprctl keyword input:repeat_rate 50 && hyprctl keyword input:repeat_delay 200 ;;
    *Normal*) hyprctl keyword input:repeat_rate 35 && hyprctl keyword input:repeat_delay 250 ;;
    *Slow*) hyprctl keyword input:repeat_rate 20 && hyprctl keyword input:repeat_delay 400 ;;
    *Escape*) hyprctl keyword input:kb_options "caps:escape" ;;
    *Ctrl*) hyprctl keyword input:kb_options "caps:ctrl_modifier" ;;
    *Caps*) hyprctl keyword input:kb_options "" ;;
    *NumLock\ On*) hyprctl keyword input:kb_options "numpad:microsoft" ;;
    *NumLock\ Off*) hyprctl keyword input:kb_options "" ;;
esac