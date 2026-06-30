# dotfiles

Personal configuration files and scripts for my daily Linux setup.

## Overview

This repository contains configuration and helper scripts for common tools and systems I use:
- Alacritty (terminal)
- Hyprland (wayland compositor)
- DWM (tiling window manager) and patches
- Rofi / Wofi (launchers)
- Neovim (`nvim`)
- slstatus, mako, dunst and other utilities
- Shell configs (fish, bash, zsh)

## Requirements

- Linux with a Wayland/X11 environment (depending on target component)
- Build tools for C programs when rebuilding `dwm` or `slstatus` (gcc/make)

## Quick install

Clone the repo and run the included installer script (preferred):

```bash
git clone https://github.com/muhamedanwer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

If you prefer manual setup, create symlinks for the files you want to use, for example:

```bash
ln -s ~/dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## Notable files and scripts

- `install.sh` — opinionated installer that symlinks configs and installs helper tools
- `setup_obsidian_vault.sh` — helper for Obsidian vault setup
- `hypr/` — Hyprland configs and helper scripts
- `dwm/` — `dwm` source, configs, and local patches (check `dwm/README` and `config.h` before rebuilding)
- `alacritty/`, `nvim/`, `rofi/`, `waybar/`, `slstatus/` — per-app configuration folders

## Contributing

Feel free to open issues or PRs. If you add changes that affect other systems (dwm patches, service files), include usage notes and rebuild instructions.

## License

Specify a license in this file (e.g. MIT) or add a `LICENSE` file.

## Contact

- Muhammad Anwer — muhamedanwer@outlook.com
- Repo: https://github.com/muhamedanwer/dotfiles
      