#!/bin/bash
hyprctl -j getoption keyword | jq -r '.str' 2>/dev/null || echo "us"
