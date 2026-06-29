#!/bin/bash
# System Health Check - Quick overview of matte black setup
# ~/.local/bin/health-check.sh

echo "╔══════════════════════════════════════════════════════════╗"
echo "║          Matte Black System Health Check                  ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo

# Hyprland
echo "▸ Hyprland"
hyprctl version | head -1 | sed 's/^/  /'
hyprctl monitors -j | jq -r '.[] | "  \(.name): \(.width)x\(.height)@\(.refreshRate)Hz"'

echo

# Waybar
echo "▸ Waybar"
pgrep waybar >/dev/null && echo "  Running" || echo "  Not running"

echo

# Mako
echo "▸ Mako"
pgrep mako >/dev/null && echo "  Running" || echo "  Not running"

echo

# Battery
echo "▸ Battery"
for bat in /sys/class/power_supply/BAT*; do
    [[ -d "$bat" ]] || continue
    cap=$(cat "$bat/capacity" 2>/dev/null)
    stat=$(cat "$bat/status" 2>/dev/null)
    echo "  $(basename $bat): ${cap}% ($stat)"
done

echo

# Network
echo "▸ Network"
ip -brief addr show | grep -v "lo " | sed 's/^/  /'

echo

# Disk
echo "▸ Disk"
df -h / | tail -1 | awk '{print "  Root: " $3 " / " $2 " (" $5 " used)"}'
df -h /home 2>/dev/null | tail -1 | awk '{print "  Home: " $3 " / " $2 " (" $5 " used)"}'

echo

# Memory
echo "▸ Memory"
free -h | awk 'NR==2{print "  RAM: " $3 " / " $2 " (" int($3/$2*100) "%)"}'

echo

# CPU
echo "▸ CPU"
echo "  $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
echo "  Load: $(uptime | awk -F'load average:' '{print $2}')"

echo

# Focus mode
echo "▸ Focus Mode"
[[ -f /tmp/hypr-focus-mode ]] && echo "  ENABLED" || echo "  Disabled"

echo

# Wallpaper
echo "▸ Wallpaper"
current=$(swww query 2>/dev/null | grep -oP 'image: \K.*' || echo "Unknown")
echo "  $(basename "$current")"

echo
echo "═══════════════════════════════════════════════════════════"