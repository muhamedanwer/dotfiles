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

BACKUP_DIR="$HOME/.local/share/dotfiles-backup/$(date +%Y%m%d%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_target() {
    local target="$1"
    local backup="$BACKUP_DIR${target#$HOME}"
    mkdir -p "$(dirname "$backup")"
    mv "$target" "$backup"
    echo "  Backed up $target -> $backup"
}

prepare_package() {
    local package="$1"
    local package_dir="$DOTFILES_DIR/$package"
    local src target rel

    while IFS= read -r src; do
        rel="${src#"$package_dir"/}"
        target="$HOME/$rel"

        if [[ -L "$target" ]]; then
            if [[ "$(readlink -f "$target")" != "$(readlink -f "$src")" ]]; then
                backup_target "$target"
            fi
        elif [[ -e "$target" && ! -d "$target" ]]; then
            backup_target "$target"
        fi
    done < <(find "$package_dir" -mindepth 1 -print)
}

echo "Stowing configurations..."

PACKAGES=(alacritty bash fastfetch fish git hypr mako nvim opencode rofi scripts starship swaylock waybar wofi zsh)
for package in "${PACKAGES[@]}"; do
    if [[ -d "$package" ]]; then
        echo "  Preparing $package..."
        prepare_package "$package"
        echo "  Stowing $package..."
        stow -v -R -t "$HOME" "$package"
    fi
 done

mkdir -p "$HOME/.local/bin"
echo "Dotfiles installed successfully!"
echo "Restart Hyprland or run 'hyprctl reload' to apply changes"