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

**Root-level dotfiles**: `.vimrc`, `.xinitrc` (managed via `root/` package), `.zshrc` (managed via `zsh/` package).

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
- Symlink all configs into place

### Manual setup
If you prefer selective installation, symlink individual packages (directories):

```bash
cd ~/dotfiles
stow alacritty    # Creates ~/.config/alacritty/ symlink
stow nvim         # Creates ~/.config/nvim/ symlink
stow fish         # Creates ~/.config/fish/ symlink
stow root         # Creates ~/.vimrc, ~/.xinitrc symlinks
stow zsh          # Creates ~/.zshrc symlink
```

## Package Structure

Each package follows the standard Stow layout where configs are placed under `.config/<app>/` or at the root level:

```
dotfiles/
├── alacritty/.config/alacritty/     # → ~/.config/alacritty/
├── bash/                            # → ~/.bash_profile, ~/.bashrc
├── dunst/.config/dunst/             # → ~/.config/dunst/
├── fastfetch/.config/fastfetch/     # → ~/.config/fastfetch/
├── fish/.config/fish/               # → ~/.config/fish/
├── hypr/.config/hypr/               # → ~/.config/hypr/
├── mako/.config/mako/               # → ~/.config/mako/
├── nvim/.config/nvim/               # → ~/.config/nvim/
├── opencode/.config/opencode/       # → ~/.config/opencode/
├── rofi/.config/rofi/               # → ~/.config/rofi/
├── root/                            # → ~/.vimrc, ~/.xinitrc
├── scripts/.local/bin/              # → ~/.local/bin/
├── starship/.config/                # → ~/.config/starship.toml
├── swaylock/.config/swaylock/       # → ~/.config/swaylock/
├── waybar/.config/waybar/           # → ~/.config/waybar/
├── wofi/.config/wofi/               # → ~/.config/wofi/
└── zsh/                             # → ~/.zshrc
```

## Key files & scripts

- `install.sh` — automated setup with Stow
- `setup_obsidian_vault.sh` — Obsidian vault initialization helper
- `dwm/` — DWM source with custom patches and config (see `dwm/README`, rebuild with `make`)
- `slstatus/` — slstatus source with custom config (rebuild with `make`)
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
      