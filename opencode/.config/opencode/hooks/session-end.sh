#!/usr/bin/env bash
# Called when an OpenCode session ends

echo "⏹️  Ending OpenCode session..."

# Log session end
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Session ended" >> "$HOME/.config/opencode/logs/sessions.log"

# Optional: Cleanup temporary files
TMP_DIR="$HOME/.config/opencode/cache"
if [[ -d "$TMP_DIR" ]]; then
    find "$TMP_DIR" -type f -mtime +7 -delete 2>/dev/null || true
fi

echo "✓ Session cleanup complete"
exit 0
