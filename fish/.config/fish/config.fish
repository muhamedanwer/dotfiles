# Fish Shell Configuration - Matte Black Productivity Setup

function is_installed
    type -q $argv[1]
end

# Disable the default Fish welcome message
set -g fish_greeting ''

# Starship Prompt
if is_installed starship
    starship init fish | source
end

# ========================================
# ALIASES
# ========================================

# Modern replacements
if is_installed eza
    alias ls="eza --icons --group-directories-first"
    alias ll="eza -l --icons --git --group-directories-first"
    alias la="eza -la --icons --git --group-directories-first"
    alias lt="eza --tree --icons --level=2"
    alias lta="eza --tree --icons --level=3 -a"
else if is_installed exa
    alias ls="exa --icons --group-directories-first"
    alias ll="exa -l --icons --git --group-directories-first"
    alias la="exa -la --icons --git --group-directories-first"
    alias lt="exa --tree --icons --level=2"
    alias lta="exa --tree --icons --level=3 -a"
else
    alias ls="ls --color=auto"
    alias ll="ls -l --color=auto"
    alias la="ls -la --color=auto"
    alias lt="ls --color=auto"
    alias lta="ls --color=auto"
end

if is_installed bat
    alias cat="bat --style=numbers,changes --theme=ansi"
end

if is_installed rg
    alias grep="rg --smart-case"
end

if is_installed fd
    alias find="fd"
end

if is_installed dust
    alias du="dust"
end

if is_installed duf
    alias df="duf"
end

if is_installed procs
    alias ps="procs"
end

if is_installed btm
    alias top="btm"
    alias htop="btm"
end

# Git
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gc="git commit -v"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate -20"
alias gla="git log --oneline --graph --decorate --all"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gba="git branch -a"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
abbr -a ~ 'cd ~'
abbr -a - 'cd -'

# Config editing
alias hyprconf="nvim ~/.config/hypr/hyprland.conf"
alias waybarconf="nvim ~/.config/waybar/config.jsonc"
alias waybarstyle="nvim ~/.config/waybar/style.css"
alias fishconf="nvim ~/.config/fish/config.fish"
alias starshipconf="nvim ~/.config/starship.toml"
alias nvimconf="nvim ~/.config/nvim/"
alias alacrittyconf="nvim ~/.config/alacritty/alacritty.toml"
alias roficonf="nvim ~/.config/rofi/quick-input.rasi"
alias wofiiconf="nvim ~/.config/wofi/config"
alias makoconf="nvim ~/.config/mako/config"

# Productivity
alias focus="~/.config/hypr/scripts/focus-mode.sh"
alias pomo="pomodoro start 25"
alias pomolong="pomodoro start 50"
alias pombreak="pomodoro start 5"
alias pombreaklong="pomodoro start 15"
alias tasks="taskwarrior-tui"
alias taskadd="task add"
alias taskdone="task done"
alias timew="timetrap"
alias timein="timetrap in"
alias timeout="timetrap out"

# System
alias update="sudo pacman -Syu && yay -Syu"
alias cleanup="yay -Sc && sudo pacman -Sc"
alias orphan="pacman -Qtdq | sudo pacman -Rns -"
alias ports="ss -tulpn"
alias myip="curl -s ifconfig.me"
alias localip="ip route get 1 | awk '{print \$7}'"

# Utils
alias c="clear"
alias h="history"
alias path='echo $PATH | tr ":" "\n"'
alias reload="exec fish"
alias dots="cd ~/dotfiles"

# ========================================
# FUNCTIONS
# ========================================

# Create dir and cd into it
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Extract any archive
function extract
    if test -f $argv[1]
        switch $argv[1]
            case *.tar.bz2; tar xjf $argv[1]
            case *.tar.gz;  tar xzf $argv[1]
            case *.bz2;     bunzip2 $argv[1]
            case *.rar;     unrar x $argv[1]
            case *.gz;      gunzip $argv[1]
            case *.tar;     tar xf $argv[1]
            case *.tbz2;    tar xjf $argv[1]
            case *.tgz;     tar xzf $argv[1]
            case *.zip;     unzip $argv[1]
            case *.Z;       uncompress $argv[1]
            case *.7z;      7z x $argv[1]
            case *;         echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Find process by name
function psg
    ps aux | grep -i $argv[1] | grep -v grep
end

# Kill process by name
function psk
    pkill -f $argv[1]
end

# Quick weather
function weather
    curl -s "wttr.in/$argv[1]?format=3"
end

# Cheat sheet
function cheat
    curl -s "cheat.sh/$argv[1]"
end

# Git commit with conventional format
function gcm
    set types "feat" "fix" "docs" "style" "refactor" "perf" "test" "chore" "build" "ci" "revert"
    set type (printf "%s\n" $types | fzf --prompt="Commit type: ")
    if test -z "$type"
        return 1
    end
    echo -n "Scope (optional): "
    read -l scope
    echo -n "Message: "
    read -l msg
    if test -n "$scope"
        git commit -m "$type($scope): $msg"
    else
        git commit -m "$type: $msg"
    end
end

# Fuzzy file open with nvim
function v
    if test (count $argv) -eq 0
        nvim (fzf --preview='bat --color=always {}')
    else
        nvim $argv
    end
end

# Fuzzy search and cd
function zz
    cd (zoxide query -l | fzf --height 40% --reverse)
end

# Pomodoro session
function focus-session
    set duration (math "$argv[1] 25" 2>/dev/null; or echo 25)
    set brk (math "$argv[2] 5" 2>/dev/null; or echo 5)
    focus
    pomodoro start $duration
    notify-send "Focus Session" "$duration"min focus started"
    sleep (math "$duration * 60")
    pomodoro start $brk
    notify-send "Break Time" "$brk"min break - stretch!"
end

# Timesheet export
function timesheet
    timetrap display --format csv > ~/timesheet-(date +%Y-%m-%d).csv
end

# ========================================
# INITIALIZATION
# ========================================

# Zoxide
if is_installed zoxide
    zoxide init fish | source
end

# FZF
if is_installed fzf
    if test -f /usr/share/fzf/key-bindings.fish
        source /usr/share/fzf/key-bindings.fish
    end
    if test -f /usr/share/fzf/completion.fish
        source /usr/share/fzf/completion.fish
    end
end

# Atuin (history sync)
if command -v atuin >/dev/null 2>&1
    atuin init fish | source
end

# Direnv
if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end


# Key bindings
bind \cg 'git status -sb'
bind \cl 'clear'
bind \cf 'v'
bind \cz 'zz'