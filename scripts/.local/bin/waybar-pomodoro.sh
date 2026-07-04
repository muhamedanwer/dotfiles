#!/bin/bash
# Enhanced Pomodoro Timer for Waybar
# Fixed bugs:
#   - status now always outputs JSON (waybar return-type: json)
#   - short-break / long-break command names match config (hyphens)
#   - toggle resume: DURATION_FILE stores seconds consistently; last-minute bug eliminated
#   - handle_session_complete stores seconds (not minutes) in DURATION_FILE
#   - start_timer stores seconds in DURATION_FILE for consistency

STATE_FILE="/tmp/pomodoro_state"
DURATION_FILE="/tmp/pomodoro_duration"   # always in SECONDS
END_TIME_FILE="/tmp/pomodoro_end"
MODE_FILE="/tmp/pomodoro_mode"
SESSION_FILE="/tmp/pomodoro_sessions"
TOTAL_SESSIONS_FILE="/tmp/pomodoro_total_sessions"

# Durations in minutes (converted to seconds at start_timer)
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

# Returns remaining seconds (integer), also triggers completion when timer expires
get_remaining_seconds() {
    local state
    state=$(get_state)

    if [[ "$state" == "running" ]]; then
        if [[ -f "$END_TIME_FILE" ]]; then
            local end_time now remaining
            end_time=$(cat "$END_TIME_FILE")
            now=$(date +%s)
            remaining=$(( end_time - now ))
            if [[ $remaining -le 0 ]]; then
                handle_session_complete
                echo "0"
            else
                echo "$remaining"
            fi
        else
            echo "0"
        fi

    elif [[ "$state" == "paused" ]]; then
        # DURATION_FILE always holds seconds
        [[ -f "$DURATION_FILE" ]] && cat "$DURATION_FILE" || echo "0"

    else
        # idle: show the full duration for the upcoming mode
        local mode dur_minutes
        mode=$(get_mode)
        case "$mode" in
            work)       dur_minutes=$WORK_DURATION ;;
            break)      dur_minutes=$BREAK_DURATION ;;
            long_break) dur_minutes=$LONG_BREAK_DURATION ;;
            *)          dur_minutes=$WORK_DURATION ;;
        esac
        echo $(( dur_minutes * 60 ))
    fi
}

fmt_time() {
    local secs=$1
    printf "%d:%02d" $(( secs / 60 )) $(( secs % 60 ))
}

handle_session_complete() {
    local mode sessions total_sessions
    mode=$(get_mode)
    sessions=$(get_sessions)
    total_sessions=$(get_total_sessions)

    if [[ "$mode" == "work" ]]; then
        sessions=$(( sessions + 1 ))
        total_sessions=$(( total_sessions + 1 ))
        echo "$sessions"       > "$SESSION_FILE"
        echo "$total_sessions" > "$TOTAL_SESSIONS_FILE"

        if [[ $(( sessions % SESSIONS_BEFORE_LONG_BREAK )) -eq 0 ]]; then
            echo "long_break"                          > "$MODE_FILE"
            echo $(( LONG_BREAK_DURATION * 60 ))       > "$DURATION_FILE"
            notify-send -u normal -t 5000 "Pomodoro" "🎉 $sessions sessions done — long break time!" 2>/dev/null
        else
            echo "break"                               > "$MODE_FILE"
            echo $(( BREAK_DURATION * 60 ))            > "$DURATION_FILE"
            notify-send -u normal -t 5000 "Pomodoro" "☕ Work session done — short break!" 2>/dev/null
        fi
    else
        echo "work"                                    > "$MODE_FILE"
        echo $(( WORK_DURATION * 60 ))                 > "$DURATION_FILE"
        notify-send -u normal -t 5000 "Pomodoro" "🍅 Break over — back to work!" 2>/dev/null
    fi

    echo "idle" > "$STATE_FILE"
    rm -f "$END_TIME_FILE"
    play_sound
}

play_sound() {
    (paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null || \
     paplay /usr/share/sounds/freedesktop/stereo/bell.oga 2>/dev/null || \
     beep 2>/dev/null) &
}

format_output() {
    local state mode remaining_secs time sessions total
    state=$(get_state)
    mode=$(get_mode)
    remaining_secs=$(get_remaining_seconds)
    time=$(fmt_time "$remaining_secs")
    sessions=$(get_sessions)
    total=$(get_total_sessions)

    local icon class tooltip

    case "$state" in
        running)
            case "$mode" in
                work)       icon="🍅"; class="working" ;;
                break)      icon="☕"; class="break" ;;
                long_break) icon="🌴"; class="break" ;;
            esac
            tooltip="$mode • $time remaining\\nSessions today: $total"
            ;;
        paused)
            case "$mode" in
                work)       icon="🍅"; class="paused" ;;
                break)      icon="☕"; class="paused" ;;
                long_break) icon="🌴"; class="paused" ;;
            esac
            tooltip="$mode (paused) • $time left\\nSessions today: $total\\nClick to resume"
            ;;
        idle)
            case "$mode" in
                work)       icon="🍅"; class="idle" ;;
                break)      icon="☕"; class="idle" ;;
                long_break) icon="🌴"; class="idle" ;;
            esac
            tooltip="Ready: $mode\\nSessions today: $total\\nClick to start"
            ;;
    esac

    # Always JSON — waybar config has return-type: json
    printf '{"text":"%s %s","class":"%s","tooltip":"%s"}\n' \
        "$icon" "$time" "$class" "$tooltip"
}

# start_timer: accepts duration in MINUTES
start_timer() {
    local minutes=${1:-$WORK_DURATION}
    local secs=$(( minutes * 60 ))
    echo "$secs"                           > "$DURATION_FILE"
    echo "$(( $(date +%s) + secs ))"       > "$END_TIME_FILE"
    echo "running"                         > "$STATE_FILE"
}

# ── Command dispatch ──────────────────────────────────────────────────────────
case "$1" in
    status)
        format_output
        ;;

    toggle)
        state=$(get_state)
        if [[ "$state" == "running" ]]; then
            # Pause: save remaining seconds
            if [[ -f "$END_TIME_FILE" ]]; then
                local end_time now remaining
                end_time=$(cat "$END_TIME_FILE")
                now=$(date +%s)
                remaining=$(( end_time - now ))
                [[ $remaining -lt 0 ]] && remaining=0
                echo "$remaining" > "$DURATION_FILE"
            fi
            echo "paused" > "$STATE_FILE"
            rm -f "$END_TIME_FILE"

        elif [[ "$state" == "paused" ]]; then
            # Resume: remaining is already in seconds
            local remaining
            remaining=$(cat "$DURATION_FILE")
            echo "$(( $(date +%s) + remaining ))" > "$END_TIME_FILE"
            echo "running" > "$STATE_FILE"

        else
            # Idle: start fresh for current mode
            local mode dur
            mode=$(get_mode)
            case "$mode" in
                work)       dur=$WORK_DURATION ;;
                break)      dur=$BREAK_DURATION ;;
                long_break) dur=$LONG_BREAK_DURATION ;;
                *)          dur=$WORK_DURATION ;;
            esac
            start_timer "$dur"
        fi
        ;;

    # Config sends "short-break" (hyphen) — match both spellings for safety
    short-break|short_break)
        echo "break" > "$MODE_FILE"
        start_timer "$BREAK_DURATION"
        ;;

    # Config sends "long-break" (hyphen) — match both spellings for safety
    long-break|long_break)
        echo "long_break" > "$MODE_FILE"
        start_timer "$LONG_BREAK_DURATION"
        ;;

    work)
        echo "work" > "$MODE_FILE"
        start_timer "$WORK_DURATION"
        ;;

    start)
        start_timer "${2:-$WORK_DURATION}"
        ;;

    skip)
        handle_session_complete
        ;;

    reset)
        echo "idle"        > "$STATE_FILE"
        echo "work"        > "$MODE_FILE"
        echo "0"           > "$SESSION_FILE"
        echo $(( WORK_DURATION * 60 )) > "$DURATION_FILE"
        rm -f "$END_TIME_FILE"
        ;;

    reset-sessions)
        echo "0" > "$SESSION_FILE"
        echo "0" > "$TOTAL_SESSIONS_FILE"
        ;;

    *)
        echo "Usage: $0 {status|toggle|short-break|long-break|work|start [mins]|skip|reset|reset-sessions}" >&2
        exit 1
        ;;
esac
