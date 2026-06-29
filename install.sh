#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Installing dotfiles from $DOTFILES_DIR"

if ! command -v stow >/dev/null 2>&1; then
    echo "GNU Stow not found. Installing..."
    if command -v pacman >/dev/null 2>&1; then
        sudo pacman -S --noconfirm stow
    elif command -v apt >/dev/null 2>&1; then
        sudo apt update && sudo apt install -y stow
    elif command -v dnf >/dev/null 2>&1; then
        sudo dnf install -y stow
    elif command -v brew >/dev/null 2>&1; then
        brew install stow
    else
        echo "Please install GNU Stow manually"
        exit 1
    fi
fi

cd "$DOTFILES_DIR"

echo "Stowing configurations..."

PACKAGES=(alacritty bash fastfetch fish git hypr mako nvim opencode rofi scripts starship swaylock waybar wofi zsh)
for package in "${PACKAGES[@]}"; do
    if [[ -d "$package" ]]; then
        echo "  Stowing $package..."
        stow -v -R -t "$HOME" "$package"
    fi
 done

mkdir -p "$HOME/.local/bin"
echo "Dotfiles installed successfully!"
echo "Restart Hyprland or run 'hyprctl reload' to apply changes"