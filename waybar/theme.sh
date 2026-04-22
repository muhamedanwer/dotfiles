#!/usr/bin/env bash
cat "$HOME/.colorschemes/current/hypr/theme.conf" 2>/dev/null | head -1 || echo "matte-black"