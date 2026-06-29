#!/bin/bash
# Waybar Taskwarrior Module
# ~/.local/bin/waybar-taskwarrior.sh

case "${1:-status}" in
    status)
        # Get pending tasks count
        pending=$(task +PENDING count 2>/dev/null || echo 0)
        # Get active task
        active=$(task +ACTIVE export 2>/dev/null | jq -r '.[0].description // empty' 2>/dev/null || echo "")
        # Get next task
        next=$(task +PENDING limit:1 export 2>/dev/null | jq -r '.[0].description // empty' 2>/dev/null || echo "")
        
        if [[ -n "$active" ]]; then
            text="[ACTIVE] $active"
            tooltip="Active: $active\nNext: ${next:-none}\nPending: $pending\nClick: add task, Right-click: list, Middle-click: done"
            class="active"
        elif [[ $pending -gt 0 ]]; then
            text="[PENDING] $pending"
            tooltip="Pending: $pending\nNext: ${next:-none}\nClick: add task, Right-click: list"
            class="pending"
        else
            text="[DONE] 0"
            tooltip="No pending tasks\nClick to add task"
            class="done"
        fi
        
        jq -n --arg text "$text" --arg tooltip "$tooltip" --arg class "$class" \
            '{text: $text, tooltip: $tooltip, class: $class}' 2>/dev/null || \
        printf '{"text": "%s", "tooltip": "%s", "class": "%s"}\n' "$text" "$tooltip" "$class"
        ;;
    
    add)
        desc=$(rofi -dmenu -p "New task" -theme ~/.config/rofi/quick-settings.rasi)
        [[ -n "$desc" ]] && task add "$desc" && pkill -RTMIN+11 waybar
        ;;
    
    list)
        task list | rofi -dmenu -p "Tasks" -theme ~/.config/rofi/task-list.rasi
        pkill -RTMIN+11 waybar
        ;;
    
    done)
        if task +ACTIVE export | jq -e '.[0]' >/dev/null 2>&1; then
            task +ACTIVE done
        elif [[ $(task +PENDING count) -gt 0 ]]; then
            task +PENDING limit:1 done
        fi
        pkill -RTMIN+11 waybar
        ;;
    
    start)
        uuid=$(task +PENDING limit:1 uuids 2>/dev/null)
        [[ -n "$uuid" ]] && task "$uuid" start && pkill -RTMIN+11 waybar
        ;;
    
    stop)
        task +ACTIVE stop 2>/dev/null && pkill -RTMIN+11 waybar
        ;;
esac