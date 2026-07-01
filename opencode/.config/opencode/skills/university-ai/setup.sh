#!/usr/bin/env bash
set -euo pipefail
# University AI Course Helper Setup

echo "🎓 Installing University AI Course Helper skill..."

# Determine source (script) directory and target XDG config directory
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/opencode/skills/university-ai"

mkdir -p "$TARGET_DIR"

# Copy skill files from this repository folder into the user's opencode skills directory
cp -a "$SRC_DIR"/. "$TARGET_DIR"/

echo "✓ Installed University AI Course Helper to: $TARGET_DIR"
