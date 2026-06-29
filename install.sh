#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Installing dotfiles from $DOTFILES_DIR"

if ! command -v stow &> /dev/null; then
    echo "GNU Stow not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm stow
    elif command -v apt &> /dev/null; then
        sudo apt update && sudo apt install -y stow
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y stow
    elif command -v brew &> /dev/null; then
        brew install stow
    else
        echo "Please install GNU Stow manually"
        exit 1
    fi
fi

cd "$DOTFILES_DIR"

echo "Stowing configurations..."

# Stow each config directory
for dir in */; do
    if [[ -d "$dir" && ! "$dir" =~ ^\.(git|github)$ ]]; then
        echo "  Stowing ${dir%/}..."
        stow -v -R -t "$HOME" "${dir%/}" 2>/dev/null || true
    fi
done

# Special handling for .config directories
if [[ -d "hypr" && -d "$CONFIG_DIR/hypr" ]]; then
    stow -v -R -t "$CONFIG_DIR" hypr 2>/dev/null || true
fi

if [[ -d "waybar" && -d "$CONFIG_DIR/waybar" ]]; then
    stow -v -R -t "$CONFIG_DIR" waybar 2>/dev/null || true
fi

if [[ -d "nvim" && -d "$CONFIG_DIR/nvim" ]]; then
    stow -v -R -t "$CONFIG_DIR" nvim 2>/dev/null || true
fi

if [[ -d "fish" && -d "$CONFIG_DIR/fish" ]]; then
    stow -v -R -t "$CONFIG_DIR" fish 2>/dev/null || true
fi

if [[ -d "starship" && -d "$CONFIG_DIR" ]]; then
    stow -v -R -t "$CONFIG_DIR" starship 2>/dev/null || true
fi

if [[ -d "alacritty" && -d "$CONFIG_DIR/alacritty" ]]; then
    stow -v -R -t "$CONFIG_DIR" alacritty 2>/dev/null || true
fi

if [[ -d "mako" && -d "$CONFIG_DIR/mako" ]]; then
    stow -v -R -t "$CONFIG_DIR" mako 2>/dev/null || true
fi

if [[ -d "wofi" && -d "$CONFIG_DIR/wofi" ]]; then
    stow -v -R -t "$CONFIG_DIR" wofi 2>/dev/null || true
fi

if [[ -d "rofi" && -d "$CONFIG_DIR/rofi" ]]; then
    stow -v -R -t "$CONFIG_DIR" rofi 2>/dev/null || true
fi

if [[ -d "fastfetch" && -d "$CONFIG_DIR/fastfetch" ]]; then
    stow -v -R -t "$CONFIG_DIR" fastfetch 2>/dev/null || true
fi

if [[ -d "swaylock" && -d "$CONFIG_DIR/swaylock" ]]; then
    stow -v -R -t "$CONFIG_DIR" swaylock 2>/dev/null || true
fi

if [[ -d "hyprlock" && -d "$CONFIG_DIR/hyprlock" ]]; then
    stow -v -R -t "$CONFIG_DIR" hyprlock 2>/dev/null || true
fi

if [[ -d "hypridle" && -d "$CONFIG_DIR/hypridle" ]]; then
    stow -v -R -t "$CONFIG_DIR" hypridle 2>/dev/null || true
fi

if [[ -d "opencode" && -d "$CONFIG_DIR/opencode" ]]; then
    stow -v -R -t "$CONFIG_DIR" opencode 2>/dev/null || true
fi

# Scripts
if [[ -d "scripts" ]]; then
    mkdir -p "$HOME/.local/bin"
    stow -v -R -t "$HOME/.local/bin" scripts 2>/dev/null || true
fi

# Systemd user services
if [[ -d "systemd" ]]; then
    mkdir -p "$HOME/.config/systemd/user"
    stow -v -R -t "$HOME/.config/systemd/user" systemd 2>/dev/null || true
fi

echo "Dotfiles installed successfully!"
echo "Restart Hyprland or run 'hyprctl reload' to apply changes"