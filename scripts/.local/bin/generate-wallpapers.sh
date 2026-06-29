#!/bin/bash
# Generate matte black wallpapers

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
mkdir -p "$WALLPAPER_DIR"

# Solid matte black
magick -size 1920x1080 xc:'#0a0a0a' "$WALLPAPER_DIR/matte-black.png" 2>/dev/null || \
  convert -size 1920x1080 xc:'#0a0a0a' "$WALLPAPER_DIR/matte-black.png" 2>/dev/null || \
  echo "Install imagemagick to generate wallpapers"

# Matte black with subtle gradient
magick -size 1920x1080 gradient:'#0a0a0a'-'#121212' "$WALLPAPER_DIR/matte-gradient.png" 2>/dev/null || true

# Matte black with vignette
magick -size 1920x1080 xc:'#0a0a0a' \
  \( +clone -fill '#080808' -colorize 30% -virtual-pixel edge -blur 0x300 \) \
  -compose multiply -composite "$WALLPAPER_DIR/matte-vignette.png" 2>/dev/null || true

# Minimal grid pattern
magick -size 1920x1080 xc:'#0a0a0a' \
  \( +clone -fill '#121212' -draw 'grid 40,40 1,1' -alpha off \) \
  -compose multiply -composite "$WALLPAPER_DIR/matte-grid.png" 2>/dev/null || true

echo "Wallpapers generated in $WALLPAPER_DIR"
ls -la "$WALLPAPER_DIR"/*.png 2>/dev/null