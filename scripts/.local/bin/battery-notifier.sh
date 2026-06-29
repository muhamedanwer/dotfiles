#!/bin/bash
# Battery Notifier - Systemd service for low battery warnings

BATTERY="/sys/class/power_supply/BAT0"
# Try BAT1 if BAT0 doesn't exist
[[ ! -d "$BATTERY" ]] && BATTERY="/sys/class/power_supply/BAT1"
[[ ! -d "$BATTERY" ]] && BATTERY="/sys/class/power_supply/BATC"

LOW_THRESHOLD=20
CRITICAL_THRESHOLD=10
CHECK_INTERVAL=60

last_state=""

while true; do
    [[ ! -d "$BATTERY" ]] && { sleep $CHECK_INTERVAL; continue; }
    
    capacity=$(cat "$BATTERY/capacity" 2>/dev/null || echo 100)
    status=$(cat "$BATTERY/status" 2>/dev/null || echo "Unknown")
    
    if [[ "$status" == "Discharging" ]]; then
        if [[ $capacity -le $CRITICAL_THRESHOLD ]] && [[ "$last_state" != "critical" ]]; then
            notify-send -u critical "Battery Critical" "${capacity}% remaining - Plug in now!" -t 0
            last_state="critical"
        elif [[ $capacity -le $LOW_THRESHOLD ]] && [[ "$last_state" != "low" ]]; then
            notify-send -u normal "Battery Low" "${capacity}% remaining" -t 10000
            last_state="low"
        elif [[ $capacity -gt $LOW_THRESHOLD ]]; then
            last_state=""
        fi
    else
        last_state=""
    fi
    
    sleep $CHECK_INTERVAL
done