#!/bin/bash
# Wallpaper Manager for Matte Black Theme
# ~/.local/bin/wallpaper.sh

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CURRENT_LINK="$WALLPAPER_DIR/current"
HYPRPAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

mkdir -p "$WALLPAPER_DIR"

generate() {
    echo "Generating matte black wallpapers..."
    
    # Solid matte black
    magick -size 3840x2160 xc:'#0a0a0a' "$WALLPAPER_DIR/void-black.png" 2>/dev/null || \
        convert -size 3840x2160 xc:'#0a0a0a' "$WALLPAPER_DIR/void-black.png"
    
    # Subtle vertical gradient
    magick -size 3840x2160 gradient:'#0a0a0a'-'#121212' "$WALLPAPER_DIR/matte-gradient.png" 2>/dev/null || true
    
    # Vignette
    magick -size 3840x2160 xc:'#0a0a0a' \
        \( +clone -fill '#080808' -colorize 40% -virtual-pixel edge -blur 0x500 \) \
        -compose multiply -composite "$WALLPAPER_DIR/matte-vignette.png" 2>/dev/null || true
    
    # Fine grid pattern
    magick -size 3840x2160 xc:'#0a0a0a' \
        \( +clone -fill '#121212' -draw 'grid 40,40 1,1' -alpha off \) \
        -compose multiply -composite "$WALLPAPER_DIR/matte-grid.png" 2>/dev/null || true
    
    # Carbon fiber texture
    magick -size 3840x2160 xc:'#0a0a0a' \
        \( +clone -fill '#101010' -draw 'grid 4,4 1,1' -alpha off \) \
        -compose overlay -composite \
        \( +clone -fill '#080808' -draw 'grid 8,8 1,1' -alpha off \) \
        -compose multiply -composite "$WALLPAPER_DIR/carbon-fiber.png" 2>/dev/null || true
    
    # Obsidian-like
    magick -size 3840x2160 plasma:fractal -blur 0x2 -auto-level \
        -fill '#0a0a0a' -colorize 85% "$WALLPAPER_DIR/obsidian.png" 2>/dev/null || true
    
    # Deep space (very dark with barely visible stars)
    magick -size 3840x2160 xc:'#080808' \
        \( +clone -fill '#0a0a0a' -noise Random -threshold 99.9% \) \
        -compose screen -composite "$WALLPAPER_DIR/deep-space.png" 2>/dev/null || true
    
    # Create symlinks with common names
    ln -sf void-black.png "$WALLPAPER_DIR/matte-black.png"
    ln -sf void-black.png "$WALLPAPER_DIR/gargantua-black.png"
    
    echo "Generated in $WALLPAPER_DIR"
    ls -la "$WALLPAPER_DIR"/*.png
}

set_wallpaper() {
    local wallpaper="$1"
    
    if [[ -z "$wallpaper" ]]; then
        # Interactive selection
        wallpaper=$(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" \) | \
            fzf --preview="chafa --size=80x40 {}" --preview-window=right:50%)
        [[ -z "$wallpaper" ]] && exit 1
    fi
    
    if [[ ! -f "$wallpaper" ]]; then
        wallpaper="$WALLPAPER_DIR/$wallpaper"
    fi
    
    [[ ! -f "$wallpaper" ]] && { echo "Wallpaper not found: $wallpaper"; exit 1; }
    
    # Update hyprpaper config
    sed -i "s|^wallpaper = .*|wallpaper = ,$wallpaper|" "$HYPRPAPER_CONF"
    
    # Set current symlink
    ln -sf "$wallpaper" "$CURRENT_LINK"
    
    # Apply immediately
    hyprctl hyprpaper preload "$wallpaper"
    hyprctl hyprpaper wallpaper ",$wallpaper"
    
    # Notify
    local name=$(basename "$wallpaper")
    notify-send -u low "Wallpaper" "Set to ${name%.*}" -i "$wallpaper" -t 2000
    
    echo "Set wallpaper: $wallpaper"
}

next() {
    local current=$(readlink -f "$CURRENT_LINK" 2>/dev/null || echo "$WALLPAPER_DIR/void-black.png")
    local next=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) | sort | grep -A1 "$current" | tail -1)
    [[ "$next" == "$current" ]] && next=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) | sort | head -1)
    set_wallpaper "$next"
}

prev() {
    local current=$(readlink -f "$CURRENT_LINK" 2>/dev/null || echo "$WALLPAPER_DIR/void-black.png")
    local prev=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) | sort | grep -B1 "$current" | head -1)
    [[ "$prev" == "$current" ]] && prev=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) | sort | tail -1)
    set_wallpaper "$prev"
}

random() {
    local random=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -name "*.png" -o -name "*.jpg" \) | shuf -n1)
    set_wallpaper "$random"
}

case "${1:-}" in
    generate|gen) generate ;;
    set) set_wallpaper "$2" ;;
    next|n) next ;;
    prev|p) prev ;;
    random|r) random ;;
    current|c) readlink -f "$CURRENT_LINK" ;;
    list|l) ls "$WALLPAPER_DIR"/*.{png,jpg,jpeg} 2>/dev/null ;;
    *) echo "Usage: wallpaper.sh {generate|set|next|prev|random|current|list}" ;;
esac