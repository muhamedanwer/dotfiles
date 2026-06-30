# Dotfiles

A curated Linux dotfiles repository for a matte-black, keyboard-focused Wayland setup tailored for productivity and a distraction-free workflow.

## What’s Included

- **Hyprland**: Tiling Wayland compositor with programmable workspaces, focus mode, and custom window rules
- **Rofi**: Launcher and custom menus with icon-enabled themes
- **Wofi**: Alternative Wayland launcher configuration
- **Waybar**: Minimal status bar with workspace and system indicators
- **Neovim**: Configured editor environment with dark theme styling
- **Fish + Starship**: Modern shell experience with a clean prompt
- **Alacritty**: Fast GPU-accelerated terminal settings
- **Mako**: Lightweight notification daemon
- **Fastfetch**: System information display
- **Custom scripts**: Useful utilities in `~/.local/bin`

## Repo Structure

```text
dotfiles/
├── install.sh              # Installer script with GNU Stow support
├── alacritty/              # Alacritty terminal configuration
│   └── .config/alacritty/
├── bash/                   # Bash shell configuration
│   ├── .bashrc
│   └── .bash_profile
├── fastfetch/              # Fastfetch configuration
│   └── .config/fastfetch/
├── fish/                   # Fish shell configuration
│   └── .config/fish/
├── git/                    # Git configuration
│   └── .config/git/config
├── hypr/                   # Hyprland and related configs
│   └── .config/hypr/
├── mako/                   # Mako notification config
│   └── .config/mako/
├── nvim/                   # Neovim config
│   └── .config/nvim/
├── opencode/               # Opencode configuration
│   └── .config/opencode/
├── rofi/                   # Rofi menus and theme files
│   └── .config/rofi/
├── scripts/                # Local helper scripts
│   └── .local/bin/
├── starship/               # Starship prompt config
│   └── .config/starship.toml
├── swaylock/               # Swaylock configuration
│   └── .config/swaylock/
├── wofi/                   # Wofi launcher config
│   └── .config/wofi/
└── zsh/                    # Zsh shell configuration
    └── .zshrc
```

## Installation

### Prerequisites

- `git`
- `stow`
- Optional utilities for the shell experience:
  - `eza`, `bat`, `ripgrep`, `fd`, `dust`, `duf`, `procs`, `btm`, `zoxide`, `fzf`, `starship`, `timetrap`

### Quick Install

```bash
git clone https://github.com/muhamedanwer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer uses GNU Stow to symlink config files into `$HOME` and creates backups for any existing conflicting files.

### Manual Install

```bash
cd ~/dotfiles

# Core Wayland configs
stow -t ~/.config hypr waybar nvim fish alacritty mako wofi rofi fastfetch swaylock

# Starship config
stow -t ~/.config starship

# Shell configs
stow zsh bash

# Git config
stow -t ~/.config git

# Scripts
stow -t ~/.local/bin scripts

# Opencode config
stow -t ~/.config opencode
```

## Keybindings

| Shortcut | Action |
|----------|--------|
| `SUPER+Return` | Open terminal |
| `SUPER+Space` | Launcher |
| `SUPER+E` | File manager |
| `SUPER+W` | Browser |
| `SUPER+R` | Ranger file manager |
| `SUPER+F11` | Toggle focus mode |
| `SUPER+Q` | Close active window |
| `SUPER+F` | Fullscreen |
| `SUPER+T` | Toggle floating |
| `SUPER+H/J/K/L` | Focus navigation |
| `SUPER+1-0` | Switch workspaces 1-10 |

## Focus Mode

This setup includes a dedicated focus mode that reduces visual noise by:

- removing gaps
- disabling blur and animations
- simplifying window decorations
- using a minimal Waybar layout

## Local Scripts

Included helper scripts in `scripts/.local/bin/` support:

- `focus-mode.sh`
- `power-menu.sh`
- `quick-settings.sh`
- `wallpaper.sh`
- `pomodoro-daemon.sh`
- `session-manager.sh`
- `install-tools.sh`

## License

MIT License

## Contact

Muhammad Anwer — muhamedanwer@outlook.com

GitHub: https://github.com/muhamedanwer/dotfiles
