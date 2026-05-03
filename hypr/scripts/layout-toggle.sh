#!/usr/bin/env bash
# Toggle layout per workspace: pseudo (monocle) <-> dwindle

CURRENT=$(hyprctl activeworkspace -j | jq -r '.layout')
WORKSPACE=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$CURRENT" = "pseudo" ]; then
    hyprctl dispatch workspace "$WORKSPACE"
    hyprctl dispatch dwindle
else
    hyprctl dispatch workspace "$WORKSPACE"
    hyprctl dispatch pseudo
fi