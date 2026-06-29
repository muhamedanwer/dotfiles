#!/bin/bash
# Color Picker - Copy hex color under cursor to clipboard
# ~/.local/bin/color-picker.sh

# Dependencies: hyprpicker, grim, slurp, wl-copy

MODE="${1:-pick}"

case "$MODE" in
    pick)
        # Pick single color
        hyprpicker -a -z 2>/dev/null | wl-copy
        ;;
    palette)
        # Pick multiple colors for palette
        echo "Click to pick colors (ESC to finish)..."
        colors=()
        while true; do
            color=$(hyprpicker -a -z 2>/dev/null)
            [[ -z "$color" ]] && break
            colors+=("$color")
            notify-send "Color Picked" "$color" -t 1000
        done
        
        if [[ ${#colors[@]} -gt 0 ]]; then
            printf '%s\n' "${colors[@]}" | wl-copy
            echo "Palette copied: ${colors[*]}"
        fi
        ;;
    screen)
        # Pick from screenshot
        grim -g "$(slurp)" - | hyprpicker -a -z 2>/dev/null | wl-copy
        ;;
    *)
        echo "Usage: color-picker.sh {pick|palette|screen}"
        ;;
esac