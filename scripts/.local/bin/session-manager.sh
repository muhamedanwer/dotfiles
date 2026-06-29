#!/bin/bash
# Session Manager - Save/restore work sessions

SESSION_DIR="$HOME/.local/share/sessions"
mkdir -p "$SESSION_DIR"

save_session() {
    local name="${1:-$(date +%Y%m%d-%H%M%S)}"
    local file="$SESSION_DIR/$name.session"
    
    echo "# Session: $name" > "$file"
    echo "# Saved: $(date)" >> "$file"
    echo "" >> "$file"
    
    # Save workspace layouts
    hyprctl workspaces -j | jq -r '.[] | "\(.id) \(.monitor) \(.windows | length)"' >> "$file"
    
    # Save open windows per workspace
    hyprctl clients -j | jq -r '.[] | "\(.workspace.id) \(.class) \(.title) \(.at[0]) \(.at[1]) \(.size[0]) \(.size[1]) \(.floating)"' >> "$file"
    
    # Save running apps (basic)
    ps aux | grep -E "(code|firefox|chromium|alacritty|kitty|discord|spotify|obsidian)" | grep -v grep | awk '{print $11}' | sort -u >> "$file"
    
    echo "Session saved: $file"
}

load_session() {
    local name="$1"
    local file="$SESSION_DIR/$name.session"
    
    if [[ ! -f "$file" ]]; then
        echo "Session not found: $name"
        ls "$SESSION_DIR"/*.session 2>/dev/null | sed 's|.*/||; s|\.session||'
        return 1
    fi
    
    echo "Loading session: $name"
    # Note: Full restoration requires more complex logic
    # This is a basic framework
    
    # Restore apps
    while IFS= read -r app; do
        [[ -z "$app" || "$app" =~ ^# ]] && continue
        case "$app" in
            *code*) code & ;;
            *firefox*) firefox & ;;
            *chromium*) chromium & ;;
            *alacritty*) alacritty & ;;
            *kitty*) kitty & ;;
            *discord*) discord & ;;
            *spotify*) spotify & ;;
            *obsidian*) obsidian & ;;
        esac
    done < "$file"
    
    echo "Session apps launched"
}

list_sessions() {
    ls -1 "$SESSION_DIR"/*.session 2>/dev/null | sed 's|.*/||; s|\.session||' | while read -r s; do
        echo "  $s"
    done
}

delete_session() {
    local name="$1"
    rm -f "$SESSION_DIR/$name.session"
    echo "Deleted: $name"
}

case "${1:-list}" in
    save)
        save_session "$2"
        ;;
    load)
        load_session "$2"
        ;;
    list)
        list_sessions
        ;;
    delete)
        delete_session "$2"
        ;;
    *)
        echo "Usage: $0 {save|load|list|delete} [name]"
        ;;
esac