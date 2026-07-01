#!/usr/bin/env bash
# Called when a new OpenCode session starts

echo "🚀 Starting OpenCode session..."

# Create necessary directories
mkdir -p "$HOME/.config/opencode/logs"
mkdir -p "$HOME/.config/opencode/cache"

# Log session start
echo "[$(date +'%Y-%m-%d %H:%M:%S')] Session started" >> "$HOME/.config/opencode/logs/sessions.log"

# Optional: Load environment setup
if [[ -f "$HOME/.config/opencode/.env" ]]; then
    # shellcheck disable=SC1090
    source "$HOME/.config/opencode/.env"
fi

# Optional: Show status
echo "✓ Session initialized"
exit 0
