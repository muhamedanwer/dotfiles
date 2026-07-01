#!/usr/bin/env bash
# Notify user of errors
# Usage: ./notify-error.sh <error_message>

ERROR_MSG="$1"

# Log to file
LOG_DIR="$HOME/.config/opencode/logs"
mkdir -p "$LOG_DIR"
echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $ERROR_MSG" >> "$LOG_DIR/errors.log"

# Print to stderr
echo "❌ Error: $ERROR_MSG" >&2

# Optional: send notification (requires notify-send on Linux or equivalent)
if command -v notify-send &> /dev/null; then
    notify-send -u critical "OpenCode Error" "$ERROR_MSG"
elif command -v osascript &> /dev/null; then
    osascript -e "display notification \"$ERROR_MSG\" with title \"OpenCode Error\""
fi

exit 0
