#!/bin/bash
# Pomodoro Timer Daemon - Runs in background
# ~/.local/bin/pomodoro-daemon.sh

STATE_FILE="/tmp/waybar-pomodoro-state"
TIME_FILE="/tmp/waybar-pomodoro-time"

while true; do
    sleep 1
    [[ -f "$STATE_FILE" ]] && ~/.local/bin/waybar-pomodoro.sh tick
done