#!/bin/bash
# Focus Mode Toggle for Hyprland
# Toggles gaps, borders, blur, notifications, and waybar

STATE_FILE="/tmp/hypr-focus-mode"
WAYBAR_STYLE="/home/anwar/.config/waybar/style.css"
WAYBAR_STYLE_FOCUS="/home/anwar/.config/waybar/style-focus.css"

# Create focus variant of waybar style if it doesn't exist
if [[ ! -f "$WAYBAR_STYLE_FOCUS" ]]; then
    cat > "$WAYBAR_STYLE_FOCUS" << 'EOF'
/* Focus Mode - Ultra Minimal Waybar */
* { border: none; border-radius: 0; font-family: "JetBrains Mono Nerd Font", monospace; font-size: 11px; min-height: 0; }
window#waybar { background: rgba(8, 8, 8, 0.98); color: #505050; border-bottom: none; }
#workspaces, #clock, #pulseaudio, #network, #battery, #tray { padding: 0 6px; margin: 2px 1px; }
#workspaces button { padding: 0 8px; color: #303030; }
#workspaces button.active { color: #707070; font-weight: bold; }
#workspaces button:hover { background: transparent; color: #505050; }
#clock { color: #505050; font-weight: 400; }
#pulseaudio, #network, #battery { color: #404040; }
#tray { opacity: 0.3; }
tooltip { background: rgba(12, 12, 12, 0.98); border: 1px solid #1a1a1a; border-radius: 6px; }
EOF
fi

if [[ -f "$STATE_FILE" ]]; then
    # ============ EXIT FOCUS MODE ============
    
    # Restore gaps & borders
    hyprctl keyword general:gaps_in 3
    hyprctl keyword general:gaps_out 5
    hyprctl keyword general:border_size 1
    hyprctl keyword general:col.active_border "rgba(00000000)"
    hyprctl keyword general:col.inactive_border "rgba(00000000)"
    
    # Restore blur & shadows
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:shadow:enabled true
    hyprctl keyword decoration:shadow:range 28
    hyprctl keyword decoration:shadow:render_power 3
    
    # Restore rounding
    hyprctl keyword decoration:rounding 14
    
    # Restore animations
    hyprctl keyword animations:enabled true
    
    # Restore waybar
    pkill -SIGUSR2 waybar 2>/dev/null || true
    # Reload waybar with normal style
    killall waybar 2>/dev/null
    sleep 0.2
    waybar -c /home/anwar/.config/waybar/config.jsonc -s /home/anwar/.config/waybar/style.css &
    
    # Restore mako
    makoctl set-mode default
    
    # Remove state
    rm "$STATE_FILE"
    
    notify-send -u low "Focus Mode" "Disabled" -t 1500
    
else
    # ============ ENTER FOCUS MODE ============
    
    # Zero gaps & borders
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:border_size 0
    hyprctl keyword general:col.active_border "rgba(00000000)"
    hyprctl keyword general:col.inactive_border "rgba(00000000)"
    
    # Disable blur & shadows
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword decoration:shadow:enabled false
    
    # Zero rounding
    hyprctl keyword decoration:rounding 0
    
    # Disable animations
    hyprctl keyword animations:enabled false
    
    # Minimal waybar
    killall waybar 2>/dev/null
    sleep 0.2
    waybar -c /home/anwar/.config/waybar/config.jsonc -s /home/anwar/.config/waybar/style-focus.css &
    
    # Focus mode notifications (minimal)
    makoctl set-mode focus
    
    # Create state file
    touch "$STATE_FILE"
    
    notify-send -u low "Focus Mode" "Enabled — Distractions minimized" -t 1500
fi