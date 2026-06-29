#!/bin/bash
# Install all productivity tools for matte black setup

# Core tools (pacman)
sudo pacman -S --needed --noconfirm \
    cliphist yazi swappy grim slurp wl-clipboard \
    pamixer brightnessctl playerctl \
    zoxide fzf fd rg bat eza duf dust procs btm \
    lazygit git-delta \
    hyprlock swaylock \
    mako wofi waybar \
    alacritty kitty \
    fish starship \
    nvim \
    fastfetch \
    polkit-kde-agent \
    noto-fonts noto-fonts-emoji noto-fonts-cjk \
    ttf-jetbrains-mono-nerd ttf-firacode-nerd \
    papirus-icon-theme \
    imagemagick \
    python-pywal \
    swww \
    clipman \
    swayidle \
    hypridle \
    hyprpaper \
    grimblast \
    wf-recorder \
    wl-screenrec \
    rofi \
    dunst \
    libnotify \
    notification-daemon

# AUR tools (yay)
yay -S --needed --noconfirm \
    atuin \
    direnv \
    pomodoro-cli \
    taskwarrior-tui \
    timetrap \
    wakatime-cli \
    cold-turkey-blocker \
    nwg-look \
    grimblast-git \
    hyprpicker \
    hyprshot \
    cliphist \
    wl-clipboard-history \
    waybar-module-pomodoro \
    waybar-module-taskwarrior

echo "Install complete. Run: exec fish"