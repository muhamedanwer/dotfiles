# Matte Black Linux Productivity Setup

A distraction-free, keyboard-driven Linux environment optimized for focus and productivity.

## Components

### Window Manager: Hyprland
- Zero gaps/borders by default
- No blur, no animations (performance)
- Focus mode: `SUPER+F11` toggles ultra-minimal mode
- Layouts: dwindle (default), master, monocle (`SUPER+\`)

### Bar: Waybar
- Matte black theme (`#0a0a0a` bg, `#1a1a1a` accents)
- Modules: workspaces, clock, audio, network, battery, tray
- Focus mode style: ultra-minimal, dimmed

### Notifications: Mako
- Matte black, rounded corners
- Focus mode: minimal, no icons, 2s timeout

### Launcher: Wofi
- Matte black, centered
- DRUN, window, file modes

### Terminal: Alacritty
- 0.92 opacity, no decorations
- JetBrains Mono Nerd Font
- Matte black color palette

### Shell: Fish + Starship
- Modern aliases (eza, bat, rg, fd, zoxide)
- Productivity functions (focus, pomo, tasks)
- Minimal matte prompt

### Editor: Neovim (LazyVim)
- TokyoNight matte black theme
- Zen Mode (`<leader>z`) + Twilight (`<leader>tw`)
- Distraction-free coding

### Lock: Hyprlock / Swaylock
- Matte black with time, date, battery, network

## Keybindings

| Key | Action |
|-----|--------|
| `SUPER+Return` | Terminal |
| `SUPER+Space` | Launcher |
| `SUPER+E` | File Manager |
| `SUPER+W` | Browser |
| `SUPER+R` | Yazi (TUI FM) |
| `SUPER+V` | Clipboard History |
| `SUPER+F11` | **Toggle Focus Mode** |
| `SUPER+P` | Pomodoro (25/5) |
| `SUPER+Q` | Close Window |
| `SUPER+F` | Fullscreen |
| `SUPER+T` | Toggle Float |
| `SUPER+H/J/K/L` | Focus Navigation |
| `SUPER+SHIFT+H/J/K/L` | Resize |
| `SUPER+CTRL+H/J/K/L` | Move Window |
| `SUPER+1-0` | Workspace 1-10 |
| `SUPER+SHIFT+1-0` | Move to Workspace |
| `SUPER+\` | Layout Switcher |
| `SUPER+\`` | Scratchpad |
| `SUPER+S` | Screenshot Region |
| `SUPER+SHIFT+S` | Screenshot Full |
| `SUPER+X` | Lock |
| `SUPER+SHIFT+E` | Exit |

### Neovim
| Key | Action |
|-----|--------|
| `<leader>z` | Zen Mode |
| `<leader>tw` | Twilight |
| `<leader>Z` | Toggle Zen |

## Scripts (`~/.local/bin/`)

| Script | Purpose |
|--------|---------|
| `focus-mode.sh` | System-wide focus toggle |
| `wallpaper.sh` | Matte wallpaper generator/setter |
| `quick-settings.sh` | Rofi system menu |
| `power-menu.sh` | Rofi power menu |
| `display-menu.sh` | Display management |
| `brightness-menu.sh` | Brightness control |
| `gamma-menu.sh` | Gamma/color temp |
| `keyboard-menu.sh` | Keyboard settings |
| `touchpad-menu.sh` | Touchpad settings |
| `nightlight-toggle.sh` | Blue light filter |
| `color-picker.sh` | Screen color picker |
| `battery-notifier.sh` | Low battery warnings (systemd) |
| `waybar-pomodoro.sh` | Pomodoro timer for waybar |
| `waybar-taskwarrior.sh` | Taskwarrior integration |
| `session-manager.sh` | Save/restore work sessions |
| `install-tools.sh` | Install all dependencies |

## Focus Mode (`SUPER+F11`)

Instantly transforms environment:
- **Hyprland**: Gaps=0, Borders=0, Blur=off, Animations=off, Rounding=0
- **Waybar**: Ultra-minimal style (dimmed, no colors)
- **Mako**: Focus category (text only, 2s timeout)
- **Neovim**: Auto-enters Zen Mode if open

## Installation

```bash
# 1. Install tools
~/.local/bin/install-tools.sh

# 2. Generate wallpapers
~/.local/bin/wallpaper.sh generate

# 3. Enable battery notifier
systemctl --user enable --now battery-notifier.service

# 4. Reload Hyprland
hyprctl reload

# 5. Restart waybar
~/.local/bin/waybar-restart.sh
```

## Directory Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf      # Main config
│   ├── hyprlock.conf      # Lock screen
│   ├── hypridle.conf      # Idle management
│   ├── hyprpaper.conf     # Wallpaper
│   └── scripts/
│       └── focus-mode.sh
├── waybar/
│   ├── config.jsonc
│   ├── style.css          # Normal
│   └── style-focus.css    # Focus mode
├── mako/config
├── wofi/{config,style.css}
├── alacritty/alacritty.toml
├── fish/config.fish
├── starship.toml
├── nvim/
│   ├── lua/config/options.lua
│   └── lua/plugins/{theme,focus}.lua
├── rofi/
│   ├── quick-settings.rasi
│   ├── power-menu.rasi
│   ├── quick-input.rasi
│   └── task-list.rasi
├── fastfetch/config.jsonc
├── swaylock/config
└── systemd/user/battery-notifier.service

~/.local/bin/
├── focus-mode.sh
├── wallpaper.sh
├── quick-settings.sh
├── power-menu.sh
├── display-menu.sh
├── brightness-menu.sh
├── gamma-menu.sh
├── keyboard-menu.sh
├── touchpad-menu.sh
├── nightlight-toggle.sh
├── color-picker.sh
├── battery-notifier.sh
├── waybar-pomodoro.sh
├── waybar-taskwarrior.sh
├── session-manager.sh
├── install-tools.sh
└── waybar-restart.sh
```

## Color Palette (Matte Black)

| Role | Hex | RGB |
|------|-----|-----|
| Background | `#0a0a0a` | 10,10,10 |
| Surface | `#121212` | 18,18,18 |
| Border | `#1a1a1a` | 26,26,26 |
| Accent | `#2a2a2a` | 42,42,42 |
| Text Primary | `#d0d0d0` | 208,208,208 |
| Text Secondary | `#909090` | 144,144,144 |
| Text Muted | `#606060` | 96,96,96 |
| Red | `#d06060` | 208,96,96 |
| Green | `#70a070` | 112,160,112 |
| Yellow | `#e0a060` | 224,160,96 |
| Blue | `#70a0d0` | 112,160,208 |
| Magenta | `#b070b0` | 176,112,176 |
| Cyan | `#60b0c0` | 96,176,192 |

## Dependencies

### Core (pacman)
```
hyprland waybar mako wofi alacritty fish starship
nvim fastfetch hyprlock swaylock hyprpaper hypridle
cliphist wl-clipboard grim slurp swappy
pamixer brightnessctl playerctl
eza bat fd rg dust duf procs btm
zoxide fzf lazygit git-delta
noto-fonts noto-fonts-emoji ttf-jetbrains-mono-nerd
papirus-icon-theme imagemagick swww
```

### AUR (yay)
```
atuin direnv pomodoro-cli taskwarrior-tui timetrap
wakatime-cli cold-turkey-blocker grimblast hyprpicker
```

## Tips

1. **Start focused**: Run `focus` alias or press `SUPER+F11` at session start
2. **Pomodoro flow**: `SUPER+P` → work 25min → break 5min → repeat 4× → long break
3. **Task management**: `tasks` opens TUI, `taskadd "description"` quick adds
4. **Time tracking**: `timein project` / `timeout` / `timesheet`
5. **Session save**: `session-manager.sh save morning-session`
6. **Distraction blocking**: Install `cold-turkey-blocker` and configure

## Customization

- **Colors**: Edit `style.css`, `mako/config`, `alacritty.toml`, `starship.toml`
- **Keybinds**: Edit `hyprland.conf` KEYBINDINGS section
- **Waybar modules**: Edit `config.jsonc` modules-* arrays
- **Fish aliases**: Edit `fish/config.fish`
- **Neovim theme**: Edit `nvim/lua/plugins/theme.lua` on_colors/on_highlights