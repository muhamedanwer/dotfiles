# ─────────────────────────────────────────────
#  ZSH CONFIG — Matte Black Theme
# ─────────────────────────────────────────────

export EDITOR=vim
export TERM=xterm-256color

# ── History ───────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS       # no duplicate entries
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt SHARE_HISTORY          # share history across sessions
setopt APPEND_HISTORY         # append rather than overwrite

# ── Autocomplete ──────────────────────────────
autoload -Uz compinit && compinit

setopt AUTO_MENU              # show completion menu on tab press
setopt COMPLETE_IN_WORD       # complete from both ends of a word
setopt ALWAYS_TO_END          # move cursor to end after completion
setopt AUTO_PARAM_SLASH       # add slash after completed directories
setopt NO_CASE_GLOB           # case-insensitive globbing

# Smart case-insensitive matching
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|=* l:|=*'

# Completion menu navigation with arrow keys
zstyle ':completion:*' menu select

# Group completions by category
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{240}── %d ──%f'
zstyle ':completion:*:warnings' format '%F{238}No matches%f'

# ── Matte Black Dir / LS Colors ───────────────
#
#  Matte Black palette:
#   bg       #1C1C1C   surface  #252525   overlay  #2E2E2E
#   accent   #B0BEC5 (blue-grey)          text     #E0E0E0
#   green    #80CBC4 (teal)   yellow  #FFD54F   cyan #80DEEA
#
export LS_COLORS="\
di=1;38;5;110:\
ln=38;5;117:\
so=38;5;177:\
pi=38;5;214:\
ex=38;5;120:\
bd=38;5;241;1:\
cd=38;5;241;1:\
su=38;5;203;1:\
sg=38;5;215;1:\
tw=38;5;110;1:\
ow=38;5;110:\
*.tar=38;5;203:*.tgz=38;5;203:*.zip=38;5;203:\
*.gz=38;5;203:*.bz2=38;5;203:*.xz=38;5;203:*.7z=38;5;203:\
*.jpg=38;5;176:*.jpeg=38;5;176:*.png=38;5;176:\
*.gif=38;5;176:*.svg=38;5;176:\
*.mp4=38;5;177:*.mkv=38;5;177:\
*.mp3=38;5;180:*.flac=38;5;180:\
*.pdf=38;5;167:\
*.md=38;5;152:*.json=38;5;149:*.yaml=38;5;149:\
*.yml=38;5;149:*.toml=38;5;149:*.conf=38;5;145:\
*.sh=38;5;120:*.py=38;5;117:*.js=38;5;221:\
*.ts=38;5;75:*.rs=38;5;208:*.go=38;5;81:\
*.c=38;5;110:*.cpp=38;5;110:*.h=38;5;109:"

# Apply same colors to completion list
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# ── Aliases ───────────────────────────────────
alias install="sudo pacman -S"
alias remove="sudo pacman -R"
alias upgrade="sudo pacman -U"
alias update="sudo pacman -Syu"

alias ls="ls --color=auto"
alias ll="ls -alh --color=auto"
alias la="ls -A --color=auto"
alias lt="ls --color=auto -t --reverse"     # sorted by time, newest last
alias l.="ls -d .* --color=auto"            # dotfiles only

alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias diff="diff --color=auto"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias mkdir="mkdir -p"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -Iv"

# ── Key Bindings ──────────────────────────────
bindkey -e                                   # emacs-style (default shell feel)
bindkey '^[[A' history-search-backward       # up arrow   → history search
bindkey '^[[B' history-search-forward        # down arrow → history search
bindkey '^[[1;5C' forward-word               # Ctrl+Right → skip word
bindkey '^[[1;5D' backward-word              # Ctrl+Left  → skip word
bindkey '^[[3~' delete-char                  # Delete key

# ── Useful Options ────────────────────────────
setopt AUTO_CD                               # type a dir name to cd into it
setopt CORRECT                               # suggest corrections on typos
setopt INTERACTIVE_COMMENTS                  # allow # comments in shell
setopt EXTENDED_GLOB                         # extended pattern matching

# ── Starship Prompt ───────────────────────────
eval "$(starship init zsh)"
