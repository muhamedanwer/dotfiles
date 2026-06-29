#!/bin/bash
# Enhanced Pomodoro Timer for Waybar
# Features: Work/Break cycles, session tracking, notifications, sound alerts

STATE_FILE="/tmp/pomodoro_state"
DURATION_FILE="/tmp/pomodoro_duration"
END_TIME_FILE="/tmp/pomodoro_end"
MODE_FILE="/tmp/pomodoro_mode"
SESSION_FILE="/tmp/pomodoro_sessions"
TOTAL_SESSIONS_FILE="/tmp/pomodoro_total_sessions"

WORK_DURATION=25
BREAK_DURATION=5
LONG_BREAK_DURATION=15
SESSIONS_BEFORE_LONG_BREAK=4

get_state() {
    [[ -f "$STATE_FILE" ]] && cat "$STATE_FILE" || echo "idle"
}

get_mode() {
    [[ -f "$MODE_FILE" ]] && cat "$MODE_FILE" || echo "work"
}

get_sessions() {
    [[ -f "$SESSION_FILE" ]] && cat "$SESSION_FILE" || echo "0"
}

get_total_sessions() {
    [[ -f "$TOTAL_SESSIONS_FILE" ]] && cat "$TOTAL_SESSIONS_FILE" || echo "0"
}

get_remaining() {
    local state=$(get_state)
    local mode=$(get_mode)
    
    if [[ "$state" == "running" ]]; then
        if [[ -f "$END_TIME_FILE" ]]; then
            local end_time=$(cat "$END_TIME_FILE")
            local now=$(date +%s)
            local remaining=$((end_time - now))
            if [[ $remaining -le 0 ]]; then
                handle_session_complete
                return
            else
                printf "%d:%02d" $((remaining / 60)) $((remaining % 60))
            fi
        else
            echo "0:00"
        fi
    elif [[ "$state" == "paused" ]]; then
        if [[ -f "$DURATION_FILE" ]]; then
            local remaining=$(cat "$DURATION_FILE")
            printf "%d:%02d" $((remaining / 60)) $((remaining % 60))
        else
            echo "0:00"
        fi
    else
        local duration
        case "$mode" in
            work) duration=$WORK_DURATION ;;
            break) duration=$BREAK_DURATION ;;
            long_break) duration=$LONG_BREAK_DURATION ;;
            *) duration=$WORK_DURATION ;;
        esac
        printf "%d:00" $duration
    fi
}

handle_session_complete() {
    local mode=$(get_mode)
    local sessions=$(get_sessions)
    local total_sessions=$(get_total_sessions)
    
    notify-send -u normal -t 5000 "Pomodoro" "🍅 $mode session complete!" 2>/dev/null
    play_sound
    
    if [[ "$mode" == "work" ]]; then
        sessions=$((sessions + 1))
        total_sessions=$((total_sessions + 1))
        echo "$sessions" > "$SESSION_FILE"
        echo "$total_sessions" > "$TOTAL_SESSIONS_FILE"
        
        if [[ $((sessions % SESSIONS_BEFORE_LONG_BREAK)) -eq 0 ]]; then
            echo "long_break" > "$MODE_FILE"
            echo "$LONG_BREAK_DURATION" > "$DURATION_FILE"
            notify-send -u normal -t 5000 "Pomodoro" "🎉 Time for a long break!" 2>/dev/null
        else
            echo "break" > "$MODE_FILE"
            echo "$BREAK_DURATION" > "$DURATION_FILE"
        fi
    else
        echo "work" > "$MODE_FILE"
        echo "$WORK_DURATION" > "$DURATION_FILE"
    fi
    
    echo "idle" > "$STATE_FILE"
    rm -f "$END_TIME_FILE"
}

play_sound() {
    (paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || \
     paplay /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null || \
     beep 2>/dev/null) &
}

format_output() {
    local state=$(get_state)
    local mode=$(get_mode)
    local time=$(get_remaining)
    local sessions=$(get_sessions)
    local total=$(get_total_sessions)
    
    local icon=""
    local class=""
    local tooltip=""
    
    case "$state" in
        running)
            case "$mode" in
                work) icon="🍅"; class="running-work" ;;
                break) icon="☕"; class="running-break" ;;
                long_break) icon="🌴"; class="running-long-break" ;;
            esac
            tooltip="Pomodoro: $mode session\n$time remaining\nSessions today: $total"
            ;;
        paused)
            case "$mode" in
                work) icon="🍅"; class="paused-work" ;;
                break) icon="☕"; class="paused-break" ;;
                long_break) icon="🌴"; class="paused-long-break" ;;
            esac
            tooltip="Pomodoro: $mode session (paused)\n$time remaining\nSessions today: $total\nClick to resume"
            ;;
        idle)
            case "$mode" in
                work) icon="🍅"; class="idle-work"; dur=$WORK_DURATION ;;
                break) icon="☕"; class="idle-break"; dur=$BREAK_DURATION ;;
                long_break) icon="🌴"; class="idle-long-break"; dur=$LONG_BREAK_DURATION ;;
            esac
            tooltip="Pomodoro: Ready to start $mode\nDuration: ${dur} min\nSessions today: $total\nClick to start"
            ;;
    esac
    
    if [[ "$1" == "json" ]]; then
        printf '{"text": "%s %s", "class": "%s", "tooltip": "%s"}' "$icon" "$time" "$class" "$tooltip"
    else
        echo "$icon $time"
    fi
}

start_timer() {
    local duration=${1:-$WORK_DURATION}
    local mode=$(get_mode)
    echo "$duration" > "$DURATION_FILE"
    echo "$(( $(date +%s) + duration * 60 ))" > "$END_TIME_FILE"
    echo "running" > "$STATE_FILE"
}

case "$1" in
    status)
        format_output "${2:-string}"
        ;;
    start)
        start_timer "$2"
        ;;
    toggle)
        state=$(get_state)
        if [[ "$state" == "running" ]]; then
            if [[ -f "$END_TIME_FILE" ]]; then
                end_time=$(cat "$END_TIME_FILE")
                now=$(date +%s)
                remaining=$((end_time - now))
                if [[ $remaining -gt 0 ]]; then
                    echo "$remaining" > "$DURATION_FILE"
                    echo "paused" > "$STATE_FILE"
                    rm -f "$END_TIME_FILE"
                fi
            fi
        elif [[ "$state" == "paused" ]]; then
            remaining=$(cat "$DURATION_FILE")
            if [[ $remaining -lt 60 ]]; then
                remaining=$((remaining * 60))
            fi
            echo "$(( $(date +%s) + remaining ))" > "$END_TIME_FILE"
            echo "running" > "$STATE_FILE"
        else
            start_timer "$2"
        fi
        ;;
    reset)
        echo "idle" > "$STATE_FILE"
        echo "work" > "$MODE_FILE"
        echo "0" > "$SESSION_FILE"
        rm -f "$END_TIME_FILE"
        echo "$WORK_DURATION" > "$DURATION_FILE"
        ;;
    skip)
        handle_session_complete
        ;;
    work)
        echo "work" > "$MODE_FILE"
        start_timer "$WORK_DURATION"
        ;;
    break)
        echo "break" > "$MODE_FILE"
        start_timer "$BREAK_DURATION"
        ;;
    long_break)
        echo "long_break" > "$MODE_FILE"
        start_timer "$LONG_BREAK_DURATION"
        ;;
    menu)
        state=$(get_state)
        mode=$(get_mode)
        sessions=$(get_sessions)
        total=$(get_total_sessions)
        
        if [[ "$state" == "running" ]]; then
            echo "Pause|toggle"
            echo "Skip|skip"
            echo "Reset|reset"
        elif [[ "$state" == "paused" ]]; then
            echo "Resume|toggle"
            echo "Reset|reset"
        else
            echo "Start Work (25m)|start 25"
            echo "Start Short Break (5m)|start 5"
            echo "Start Long Break (15m)|start 15"
            echo "Reset|reset"
        fi
        echo "---"
        echo "Mode: $mode | Sessions: $total"
        ;;
esac