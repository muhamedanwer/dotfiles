# dotfiles

Personal Linux configuration files and system setup scripts.

## Overview

This repository contains dotfiles and configs for my daily desktop environment:

**Core Tools**
- **Terminal**: Alacritty (TOML config)
- **Editor**: Neovim (Lua config with Lazy plugin manager)
- **Launchers**: Rofi
- **Compositor**: Hyprland (Wayland)
- **Window Managers**: DWM (X11) with custom patches, slstatus (status bar)
- **Utilities**: Mako, Dunst, Waybar, Wofi, Swaylock, Picom
- **Shells**: Fish, Bash, Zsh
- **Other**: Starship, Fastfetch, opencode

**Root-level dotfiles**: `.vimrc`, `.xinitrc`, `.zshrc`, `hyprland.conf`, `picom.conf`, plus input device configs.

## Setup

### Automatic (recommended)
The repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks:

```bash
git clone https://github.com/muhamedanwer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer will:
- Install Stow if not present (pacman, apt, dnf, or brew)
- Backup any conflicting files to `~/.local/share/dotfiles-backup/`
- Symlink all configs into place

### Manual setup
If you prefer selective installation, symlink individual packages (directories):

```bash
cd ~/dotfiles
stow alacritty    # Creates ~/.config/alacritty/ symlink
stow nvim         # Creates ~/.config/nvim/ symlink
stow fish         # Creates ~/.config/fish/ symlink
```

## Key files & scripts

- `install.sh` — automated setup with Stow and optional package installation
- `setup_obsidian_vault.sh` — Obsidian vault initialization helper
- `dwm/` — DWM source with custom patches and config (see `dwm/README`, rebuild with `make`)
- `hypr/` — Hyprland config and helper scripts
- `scripts/` — utility scripts (e.g., for status bar, keyboard layout)
- `nvim/` — Neovim Lua config with lazy.nvim
- Per-app configs: `alacritty/`, `rofi/`, `waybar/`, `mako/`, `dunst/`, `fish/`, `bash/`, `zsh/`, etc.

## Contributing

Contributions, suggestions, and forks are welcome! If you add changes, please:
- Document any new dependencies or build steps
- Test on your environment before submitting PRs
- Include notes for config-specific changes (e.g., DWM patches need rebuild)

## License

See LICENSE file (or specify MIT, GPL, etc.).

## Contact

- Muhammad Anwer — muhamedanwer@outlook.com
- Repo: https://github.com/muhamedanwer/dotfiles
      