#!/bin/bash
layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | head -1)
case "$layout" in
    "English (US)"*) echo '{"text": "US", "tooltip": "English (US)"}' ;;
    "Arabic"*)       echo '{"text": "AR", "tooltip": "Arabic (العربية)"}' ;;
    *)               echo "{\"text\": \"${layout:0:2}\", \"tooltip\": \"$layout\"}" ;;
esac
