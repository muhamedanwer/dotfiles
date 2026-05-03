#!/bin/bash

HISTORY_FILE="/tmp/waybar_cpu_history"
MAX_POINTS=15

get_cpu() {
    top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)}'
}

draw_chart() {
    local current=$(get_cpu)
    
    if [ -f "$HISTORY_FILE" ]; then
        echo "$current" >> "$HISTORY_FILE"
        local count=$(wc -l < "$HISTORY_FILE")
        if [ "$count" -gt "$MAX_POINTS" ]; then
            tail -n "$MAX_POINTS" "$HISTORY_FILE" > "${HISTORY_FILE}.tmp" && mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"
        fi
    else
        echo "$current" > "$HISTORY_FILE"
        for i in $(seq 1 $((MAX_POINTS - 1))); do
            echo "$current" >> "$HISTORY_FILE"
        done
    fi
    
    local values=$(cat "$HISTORY_FILE")
    local chart=""
    
    for val in $values; do
        if [ "$val" -lt 10 ]; then
            chart="${chart}▁"
        elif [ "$val" -lt 20 ]; then
            chart="${chart}▂"
        elif [ "$val" -lt 30 ]; then
            chart="${chart}▃"
        elif [ "$val" -lt 40 ]; then
            chart="${chart}▄"
        elif [ "$val" -lt 50 ]; then
            chart="${chart}▅"
        elif [ "$val" -lt 60 ]; then
            chart="${chart}▆"
        elif [ "$val" -lt 70 ]; then
            chart="${chart}▇"
        else
            chart="${chart}█"
        fi
    done
    
    echo "{\"text\": \"📊 $current% $chart\", \"tooltip\": \"CPU: $current%\", \"class\": \"$( [ "$current" -gt 80 ] && echo "critical" || echo "normal" )\"}"
}

draw_chart
