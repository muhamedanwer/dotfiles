# dotfiles

Personal Linux configuration files and system setup scripts for a modern, minimal desktop environment.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Setup Instructions](#setup-instructions)
- [Package Structure](#package-structure)
- [Key Files & Scripts](#key-files--scripts)
- [Configuration Guide](#configuration-guide)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Overview

This repository contains dotfiles and configurations for a daily desktop environment with:

### Core Components

| Component | Tool | Notes |
|-----------|------|-------|
| **Terminal** | Alacritty | TOML configuration |
| **Editor** | Neovim | Lua config with Lazy plugin manager |
| **Launcher** | Rofi | Application/command launcher |
| **Compositor** | Hyprland | Modern Wayland compositor |
| **Window Manager** | DWM | X11 with custom patches & slstatus bar |
| **Notification Daemon** | Mako/Dunst | Desktop notifications |
| **Status Bar** | Waybar/slstatus | System information display |
| **Lock Screen** | Swaylock | Wayland-native screen locker |
| **Shells** | Fish, Bash, Zsh | Shell configurations |
| **Utilities** | Starship, Fastfetch, Wofi, Picom | Additional tools |

**Root-level dotfiles**: `.vimrc`, `.xinitrc` (via `root/`), `.zshrc` (via `zsh/`).

## Prerequisites

- **OS**: Linux (tested on Arch, Debian-based systems)
- **Package Manager**: pacman, apt, dnf, or brew (auto-detected by installer)
- **Git**: For cloning the repository
- **GNU Stow**: Symlink manager (auto-installed if missing)

## Quick Start

```bash
git clone https://github.com/muhamedanwer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer handles everything: checking prerequisites, installing Stow, and symlinking your configs into place.

## Setup Instructions

### Automatic Setup (Recommended)

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage symlinks. The automated setup:

```bash
./install.sh
```

**What it does:**
- Detects your package manager (pacman/apt/dnf/brew)
- Installs Stow if not already present
- Symlinks all package configurations to their proper locations
- Preserves existing configs (prompts on conflicts)

### Manual Setup

For selective installation or if you prefer to control the process:

```bash
cd ~/dotfiles
stow alacritty    # ~/.config/alacritty
stow hypr         # ~/.config/hypr (Hyprland)
stow nvim         # ~/.config/nvim (Neovim)
stow fish         # ~/.config/fish (Fish shell)
stow zsh          # ~/.zshrc (Zsh shell)
stow root         # ~/.vimrc, ~/.xinitrc
stow wallpapers   # ~/.local/share/wallpapers
# ... add other packages as needed
```

**Tip**: Install packages one at a time to identify any conflicts or issues.

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
├── wallpapers/.local/share/wallpapers/  # → ~/.local/share/wallpapers/
├── waybar/.config/waybar/           # → ~/.config/waybar/
├── wofi/.config/wofi/               # → ~/.config/wofi/
└── zsh/                             # → ~/.zshrc
```

## Key Files & Scripts

### Setup & Configuration
- `install.sh` — Automated installer with Stow setup
- `SETUP_README.md` — Comprehensive setup guide with keybindings, color schemes, and dependencies
- `setup_obsidian_vault.sh` — Helper script for Obsidian vault initialization

### Window Manager & Status Bar
- `dwm/` — DWM (X11 window manager) source code with:
  - Custom patches (gaps, transparency, systray, horizontal layout, etc.)
  - Full source build with `make`
  - See `dwm/README` for details
- `slstatus/` — Status bar source with custom components
  - Rebuild with `make` after config changes
  - Battery, CPU, memory, network, and custom modules

### Configuration Directories
- `hypr/` — Hyprland compositor with helper scripts
- `nvim/` — Neovim Lua configuration with lazy.nvim plugin manager
- `fish/`, `bash/`, `zsh/` — Shell configurations
- `alacritty/` — Terminal emulator config
- `rofi/`, `wofi/` — Application launchers
- `waybar/`, `mako/`, `dunst/` — Status bars and notifications
- `swaylock/` — Screen lock configuration
- `starship/` — Prompt configuration
- `scripts/` — Utility scripts for system management

## Configuration Guide

### Customization Tips

1. **Shell Integration**: Choose your preferred shell (Fish, Bash, or Zsh) by setting it as your default:
   ```bash
   chsh -s /usr/bin/fish  # or /bin/bash, /bin/zsh
   ```

2. **Neovim**: Customize plugins in `nvim/lua/config/` and reload with `:Lazy`

3. **DWM/slstatus**: Edit `config.h` in `dwm/` or `slstatus/` directories, then rebuild with `make`

4. **Hyprland**: Modify keybindings and layout in `hypr/hyprland.conf`

5. **Color Schemes**: Adjust terminal colors in `alacritty/alacritty.toml` or shell configs

### Key Dependencies to Install

Before using these configs, ensure you have:
- Core: `git`, `base-devel` (build tools)
- Desktop: `wayland`, `xorg-server`, `hyprland` (or `dwm`)
- Editors: `neovim`, `vim`
- Shells: `fish`, `zsh`, `bash`
- Tools: `alacritty`, `rofi`, `mako`, `dunst`, `waybar`, `stow`

See `SETUP_README.md` for a complete dependency list.

## Troubleshooting

### Common Issues

**Q: `stow` command not found**
- Run `./install.sh` to auto-install Stow for your system
- Or manually: `sudo pacman -S stow` (Arch), `sudo apt install stow` (Debian), etc.

**Q: Symlink conflicts**
- Stow will warn if a file already exists in the target location
- Backup your existing config: `mv ~/.config/alacritty ~/.config/alacritty.bak`
- Then run `stow <package>` again

**Q: DWM/slstatus won't compile**
- Ensure build tools are installed: `sudo pacman -S base-devel` or `sudo apt install build-essential`
- Check `config.h` for missing dependencies
- Run `make clean && make` in the respective directory

**Q: Hyprland not starting**
- Verify Wayland/Hyprland installation: `hyprctl version`
- Check `hypr/hyprland.conf` for syntax errors
- Review logs: `journalctl -xe`

**Q: Keybindings not working**
- Different window managers use different keymaps
- For DWM: Rebuild with `make` after editing `config.h`
- For Hyprland: Reload with `hyprctl reload`
- For shells: Source config files manually: `source ~/.config/fish/config.fish`

**Q: Shell not sourcing configs**
- Ensure your shell is set correctly: `echo $SHELL`
- Add shell configs to startup files (`.bashrc`, `.zshrc`, etc.)
- Restart your terminal or `exec $SHELL`

### Getting Help

- Check `SETUP_README.md` for detailed configuration info
- Review individual package `README` files (e.g., `dwm/README`)
- See [DWM documentation](https://dwm.suckless.org/)
- Check [Hyprland wiki](https://wiki.hyprland.org/)

## Contributing

Contributions are welcome! Guidelines:

- **Fork & create a feature branch** for your changes
- **Document dependencies** if adding new tools or packages
- **Test thoroughly** in your environment before submitting PRs
- **Note rebuild steps** for C/compiled configs (DWM, slstatus)
- **Update this README** if adding new configs or sections
- **Follow the Stow structure** for new packages (`.config/<app>/` or root-level)

Feel free to suggest improvements via issues or discussions!

## License

This repository is provided as-is. See LICENSE file for details.

## Contact & Links

**Author**: Muhammad Anwer  
**Email**: muhamedanwer@outlook.com  
**GitHub**: [@muhamedanwer](https://github.com/muhamedanwer)

---

**Inspired by**: [DWM](https://dwm.suckless.org/), [Hyprland](https://hyprland.org/), [Neovim community](https://neovim.io/)  
**Contributions**: Forks and PRs welcome!