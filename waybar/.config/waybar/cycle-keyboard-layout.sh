#!/bin/bash
main_kb=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .name' | head -1)
hyprctl switchxkblayout "$main_kb" next
