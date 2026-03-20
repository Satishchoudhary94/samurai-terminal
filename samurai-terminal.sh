#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║  ⚔️  SAMURAI TERMINAL — Ultimate Linux Terminal Makeover            ║
# ║                                                                      ║
# ║  Based on: "Give Your Linux Terminal A Stunning Makeover"            ║
# ║  Channel:  It's FOSS - Linux Portal                                  ║
# ║  Video:    https://youtu.be/ffmm80_Cii4                              ║
# ║                                                                      ║
# ║  Enhanced with: Red anime wallpaper bg, Sword (刀) prompt,           ║
# ║  anime image right side, colored boxes, all shortcuts                ║
# ║                                                                      ║
# ║  Installs: Kitty (latest) + Zsh + Starship + Fastfetch (anime)      ║
# ║            + Atuin + Nerd Fonts + eza + zsh-plugins                  ║
# ║                                                                      ║
# ║  Works on: Ubuntu 22.04+ / Debian 12+ / Fedora / Arch               ║
# ╚══════════════════════════════════════════════════════════════════════╝

set -e

R='\033[0;31m' G='\033[0;32m' Y='\033[1;33m' C='\033[0;36m'
M='\033[0;35m' B='\033[1m' NC='\033[0m'

sn=0; total=10
step()  { sn=$((sn+1)); echo ""; echo -e "${M}${B}[$sn/$total] $1${NC}"; echo -e "${M}$(printf '─%.0s' {1..55})${NC}"; }
ok()    { echo -e "  ${G}✔${NC} $1"; }
info()  { echo -e "  ${C}▶${NC} $1"; }
warn()  { echo -e "  ${Y}⚠${NC} $1"; }

echo ""
echo -e "${R}${B}"
echo "  ╔═══════════════════════════════════════════════════╗"
echo "  ║   ⚔️  SAMURAI TERMINAL — Ultimate Makeover        ║"
echo "  ║                                                   ║"
echo "  ║   Kitty + Zsh + Starship (刀) + Fastfetch        ║"
echo "  ║   + Red Anime Wallpaper + Atuin + Nerd Fonts     ║"
echo "  ║                                                   ║"
echo "  ║   One script. Full setup. Killer look.            ║"
echo "  ╚═══════════════════════════════════════════════════╝"
echo -e "${NC}"
read -p "  Press ENTER to start (Ctrl+C to cancel)... "

# ── Detect package manager ──
if command -v apt &>/dev/null; then
    PM="apt"; INS="sudo apt install -y"; UPD="sudo apt update"
elif command -v dnf &>/dev/null; then
    PM="dnf"; INS="sudo dnf install -y"; UPD="sudo dnf check-update || true"
elif command -v pacman &>/dev/null; then
    PM="pacman"; INS="sudo pacman -S --noconfirm"; UPD="sudo pacman -Sy"
else
    echo -e "${R}No supported package manager (apt/dnf/pacman)!${NC}"; exit 1
fi
ok "Package manager: $PM"


# ══════════════════════════════════════
step "System update + prerequisites"
# ══════════════════════════════════════
$UPD
$INS git curl wget unzip imagemagick
ok "Done"


# ══════════════════════════════════════
step "Installing Nerd Fonts"
# ══════════════════════════════════════
FDIR="$HOME/.local/share/fonts"
mkdir -p "$FDIR"

grab_font() {
    local name="$1" url="$2"
    if fc-list 2>/dev/null | grep -qi "$name"; then ok "$name already installed"
    else
        info "Downloading $name..."
        wget -q --show-progress -O /tmp/_font.zip "$url"
        mkdir -p "$FDIR/$name" && unzip -o -q /tmp/_font.zip -d "$FDIR/$name"
        rm -f /tmp/_font.zip
        ok "$name installed"
    fi
}

grab_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
grab_font "FiraCode"       "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"
grab_font "CascadiaCode"   "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"
fc-cache -fv >/dev/null 2>&1
ok "Font cache rebuilt"


# ══════════════════════════════════════
step "Installing Zsh + plugins"
# ══════════════════════════════════════
command -v zsh &>/dev/null || { info "Installing zsh..."; $INS zsh; }
ok "Zsh ready"

[ "$PM" = "apt" ] && $INS zsh-autosuggestions zsh-syntax-highlighting 2>/dev/null || true
[ "$PM" = "dnf" ] && $INS zsh-autosuggestions zsh-syntax-highlighting 2>/dev/null || true

if [ ! -d "$HOME/zsh-autocomplete" ]; then
    info "Cloning zsh-autocomplete..."
    git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete "$HOME/zsh-autocomplete"
fi
ok "Zsh plugins ready"


# ══════════════════════════════════════
step "Installing Starship prompt"
# ══════════════════════════════════════
command -v starship &>/dev/null || { info "Installing..."; curl -sS https://starship.rs/install.sh | sh -s -- -y; }
ok "Starship ready"

info "Writing Samurai Starship config (刀 sword prompt)..."
mkdir -p "$HOME/.config"
cat > "$HOME/.config/starship.toml" << 'STAR_EOF'
format = """
[ ](bg:#fec249)\
$os\
$username\
[](bg:#ff5757 fg:#fec249)\
$directory\
[](fg:#ff5757 bg:#57FFFF)\
$git_branch\
$git_status\
[](fg:#57FFFF bg:#ff66c4)\
$time\
[](fg:#ff66c4 bg:#5ce1e6)\
$cmd_duration\
[  ](fg:#5ce1e6)\
"""
add_newline = true

[character]
success_symbol = "[刀](bold red)"
error_symbol = "[刀](bold yellow)"

[username]
show_always = true
style_user = "bg:#fec249 fg:#000000"
style_root = "bg:#00b6ba"
format = '[$user ]($style)'
disabled = false

[os]
style = "bg:#fec249"
disabled = false

[os.symbols]
AlmaLinux = " "
Alpine = " "
Android = " "
Arch = "󰣇 "
Artix = " "
CachyOS = " "
CentOS = " "
Debian = " "
DragonFly = " "
EndeavourOS = " "
Fedora = " "
FreeBSD = " "
Garuda = " "
Gentoo = " "
Kali = " "
Linux = " "
Macos = " "
Manjaro = " "
Mint = "󰣭 "
NetBSD = "🚩 "
NixOS = "󱄅 "
Nobara = " "
OpenBSD = " "
openSUSE = " "
OracleLinux = "󰫼 "
Pop = " "
Raspbian = " "
Redhat = " "
RedHatEnterprise = " "
RockyLinux = " "
Solus = " "
SUSE = " "
Ubuntu = " "
Unknown = " "
Void = " "
Windows = " "

[directory]
style = "bg:#ff5757 fg:#000000"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "bg:#57FFFF fg:#000000"
format = '[ $symbol $branch ]($style)'

[git_status]
style = "bg:#57FFFF fg:#000000"
format = '[$all_status$ahead_behind ]($style)'

[time]
disabled = false
time_format = "%b %d, %I:%M %P"
style = "bg:#ff66c4 fg:#000000"
format = "[ $time ]($style)"

[cmd_duration]
disabled = false
min_time = 2000
style = 'bg:#5ce1e6 fg:#000000'
format = '[ Took $duration!]($style)'
STAR_EOF
ok "Starship configured (刀 katana prompt)"


# ══════════════════════════════════════
step "Installing Kitty terminal (LATEST)"
# ══════════════════════════════════════
info "Installing latest Kitty from official source..."
sudo apt remove -y kitty 2>/dev/null || true

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.local/kitty.app/bin/kitty"  "$HOME/.local/bin/kitty"
ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"

# Desktop entry
mkdir -p "$HOME/.local/share/applications"
cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" \
   "$HOME/.local/share/applications/" 2>/dev/null || true
sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" \
    "$HOME/.local/share/applications/kitty.desktop" 2>/dev/null || true
sed -i "s|Exec=kitty|Exec=$HOME/.local/bin/kitty|g" \
    "$HOME/.local/share/applications/kitty.desktop" 2>/dev/null || true

KVER=$("$HOME/.local/bin/kitty" --version 2>/dev/null || echo "installed")
ok "Kitty: $KVER"

info "Writing Kitty config..."
mkdir -p "$HOME/.config/kitty"
cat > "$HOME/.config/kitty/kitty.conf" << 'KITTY_EOF'
# ── Kitty Config (Samurai Terminal Edition) ──

# Font
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size        14.0

# Cursor
cursor                  #FF4444
cursor_text_color       #000000
cursor_shape            beam
cursor_trail            100
cursor_trail_decay      0.1 0.3

# Window — buttons visible (minimize/maximize/close)
hide_window_decorations no
remember_window_size    no
initial_window_width    140c
initial_window_height   35c
window_padding_width    6

# Background wallpaper — CHANGE THIS PATH to your wallpaper
# Default: anime-girl-katana from uhdpaper.com
background_image ~/Downloads/anime-girl-katana-tattoo-8k-wallpaper-uhdpaper.com-228@3@a.jpg
background_image_layout cscaled
background_tint 0.0
background_opacity 1

# Tab bar
tab_bar_style           powerline
tab_bar_min_tabs        1
tab_powerline_style     round
active_tab_foreground   #000000
active_tab_background   #FF4444
inactive_tab_foreground #999999
inactive_tab_background #1a0000
tab_bar_background      #0a0000

# Shell
shell /usr/bin/zsh

# Scrollback
scrollback_lines 10000
enable_audio_bell no

# Shortcuts
map f11              toggle_fullscreen
map ctrl+shift+f     toggle_fullscreen
map ctrl+shift+equal change_font_size all +1.0
map ctrl+shift+minus change_font_size all -1.0
map ctrl+shift+0     change_font_size all 0
map ctrl+shift+a>m   set_background_opacity +0.05
map ctrl+shift+a>l   set_background_opacity -0.05
map ctrl+shift+a>1   set_background_opacity 1

# Colors — white text for red wallpaper
foreground              #FFFFFF
background              #0a0000
selection_foreground    #000000
selection_background    #FF6B6B

color0  #2D0000
color8  #5C3030
color1  #FF4444
color9  #FF6B6B
color2  #44FF88
color10 #66FFAA
color3  #FFD700
color11 #FFE44D
color4  #44AAFF
color12 #66CCFF
color5  #FF44FF
color13 #FF88FF
color6  #44FFDD
color14 #66FFE8
color7  #DDDDDD
color15 #FFFFFF
KITTY_EOF
ok "Kitty configured (wallpaper + red theme + buttons visible)"


# ══════════════════════════════════════
step "Installing & configuring Fastfetch (anime RIGHT side)"
# ══════════════════════════════════════
if ! command -v fastfetch &>/dev/null; then
    info "Installing fastfetch..."
    if [ "$PM" = "apt" ]; then
        sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
        sudo apt update
        $INS fastfetch
    else
        $INS fastfetch
    fi
fi
ok "Fastfetch installed"

mkdir -p "$HOME/.config/fastfetch/assets"

info "Writing fastfetch config (anime RIGHT, content LEFT)..."
cat > "$HOME/.config/fastfetch/sample_2.jsonc" << 'FF_EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
      "source": "~/.config/fastfetch/assets/jedi.png",
      "type": "kitty-direct",
      "padding": {
          "top": 1,
          "right": 3
      },
      "width": 22,
      "height": 16,
      "position": "right"
  },
  "display": {
    "separator": "   "
  },
  "modules": [
    "break",
    {
        "type": "custom",
        "format": "\u001b[91m\u001b[1m┌──────────────────────────────────────────────────┐\u001b[0m"
    },
    {
        "type": "os",
        "key":  "\u001b[91m│\u001b[0m  \u001b[97m\u001b[1m󰧨\u001b[0m ",
        "keyColor": "white"
    },
    {
        "type": "kernel",
        "key":  "\u001b[91m│\u001b[0m  \u001b[93m\u001b[1m󰻀\u001b[0m ",
        "keyColor": "yellow"
    },
    {
        "type": "uptime",
        "key":  "\u001b[91m│\u001b[0m  \u001b[96m\u001b[1m\u001b[0m ",
        "keyColor": "cyan"
    },
    {
        "type": "custom",
        "format": "\u001b[91m\u001b[1m└──────────────────────────────────────────────────┘\u001b[0m"
    },
    "break",
    {
        "type": "custom",
        "format": "\u001b[35m\u001b[1m┌──────────── \u001b[91m󰣙 󰣙 󰣙 󰣙 󰣙 󰣙 󰣙 \u001b[35m─────────────────────┐\u001b[0m"
    },
    {
        "type": "chassis",
        "key":  "\u001b[35m│\u001b[0m  \u001b[91m\u001b[1m\u001b[0m ",
        "keyColor": "red"
    },
    {
        "type": "packages",
        "key":  "\u001b[35m│\u001b[0m  \u001b[92m\u001b[1m\u001b[0m ",
        "keyColor": "green"
    },
    {
        "type": "shell",
        "key":  "\u001b[35m│\u001b[0m  \u001b[93m\u001b[1m\u001b[0m ",
        "keyColor": "yellow"
    },
    {
        "type": "terminal",
        "key":  "\u001b[35m│\u001b[0m  \u001b[96m\u001b[1m\u001b[0m ",
        "keyColor": "cyan"
    },
    {
        "type": "custom",
        "format": "\u001b[35m\u001b[1m└──────────────────────────────────────────────────┘\u001b[0m"
    },
    "break",
    {
        "type": "custom",
        "format": "\u001b[93m\u001b[1m┌──────────── \u001b[93m⚡⚡⚡⚡⚡⚡⚡ \u001b[93m─────────────────────┐\u001b[0m"
    },
    {
        "type": "cpu",
        "key":  "\u001b[93m│\u001b[0m  \u001b[94m\u001b[1m\u001b[0m ",
        "keyColor": "blue"
    },
    {
        "type": "gpu",
        "key":  "\u001b[93m│\u001b[0m  \u001b[95m\u001b[1m󱤓\u001b[0m ",
        "keyColor": "magenta"
    },
    {
        "type": "memory",
        "key":  "\u001b[93m│\u001b[0m  \u001b[91m\u001b[1m\u001b[0m ",
        "keyColor": "red"
    },
    {
        "type": "disk",
        "key":  "\u001b[93m│\u001b[0m  \u001b[92m\u001b[1m󰋊\u001b[0m ",
        "keyColor": "green"
    },
    {
        "type": "custom",
        "format": "\u001b[93m\u001b[1m└──────────────────────────────────────────────────┘\u001b[0m"
    },
    "break",
    {
        "type": "colors",
        "paddingLeft": 6,
        "symbol": "diamond"
    }
  ]
}
FF_EOF
cp "$HOME/.config/fastfetch/sample_2.jsonc" "$HOME/.config/fastfetch/config.jsonc"
ok "Fastfetch configured (anime RIGHT, content LEFT)"

# Download jedi.png
info "Downloading jedi.png anime image..."
if [ ! -f "$HOME/.config/fastfetch/assets/jedi.png" ]; then
    cd /tmp && rm -rf _itsfoss
    git clone --depth 1 --filter=blob:none --sparse https://github.com/itsfoss/text-script-files.git _itsfoss 2>/dev/null
    cd _itsfoss && git sparse-checkout set config/fastfetch/assets 2>/dev/null
    [ -f config/fastfetch/assets/jedi.png ] && \
        cp config/fastfetch/assets/jedi.png "$HOME/.config/fastfetch/assets/jedi.png" && \
        ok "jedi.png downloaded" || warn "jedi.png not found"
    cd /tmp && rm -rf _itsfoss
else
    ok "jedi.png already exists"
fi


# ══════════════════════════════════════
step "Installing Atuin (smart shell history)"
# ══════════════════════════════════════
if ! command -v atuin &>/dev/null; then
    info "Installing Atuin..."
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi
ok "Atuin ready"


# ══════════════════════════════════════
step "Installing eza (modern ls with icons)"
# ══════════════════════════════════════
if ! command -v eza &>/dev/null; then
    info "Installing eza..."
    if [ "$PM" = "apt" ]; then
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg 2>/dev/null || true
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
        sudo apt update && $INS eza
    else
        $INS eza
    fi
fi
ok "eza ready"


# ══════════════════════════════════════
step "Downloading anime wallpaper"
# ══════════════════════════════════════
WALLPAPER="$HOME/Downloads/anime-girl-katana-tattoo-8k-wallpaper-uhdpaper.com-228@3@a.jpg"
if [ -f "$WALLPAPER" ]; then
    ok "Wallpaper already exists in Downloads"
else
    info "Wallpaper not found in Downloads."
    echo ""
    echo -e "  ${Y}Download it manually:${NC}"
    echo -e "  ${B}https://www.uhdpaper.com/2024/01/anime-girl-katana-tattoo-8k-228a.html${NC}"
    echo -e "  Save to: ~/Downloads/"
    echo ""
    echo -e "  Ya koi bhi wallpaper rakh do ~/Downloads/ mein"
    echo -e "  aur kitty.conf mein path update karo:"
    echo -e "  ${B}background_image ~/Downloads/YOUR-WALLPAPER.jpg${NC}"
    echo ""
fi


# ══════════════════════════════════════
step "Configuring .zshrc"
# ══════════════════════════════════════
[ -f "$HOME/.zshrc" ] && cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%s)"

info "Writing .zshrc..."
cat > "$HOME/.zshrc" << 'ZSH_EOF'
# ╔═══════════════════════════════════════════╗
# ║  ⚔️ Samurai Terminal .zshrc                ║
# ╚═══════════════════════════════════════════╝

# PATH
export PATH="$HOME/.local/bin:$HOME/.atuin/bin:$PATH"

# ── Fastfetch on launch (anime style) ──
if command -v fastfetch &>/dev/null; then
    fastfetch -c ~/.config/fastfetch/sample_2.jsonc
fi

# ── Zsh plugins ──
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f "$HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ] && \
    source "$HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# ── Starship prompt (刀 katana) ──
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# ── Atuin (Ctrl+R smart history) ──
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh)"
fi

# ── Aliases ──
alias cls="clear"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias df="df -h"
alias free="free -h"
alias myip="curl -s ifconfig.me"

# eza aliases (ls with icons)
if command -v eza &>/dev/null; then
    alias ls="eza --icons --color=always --group-directories-first"
    alias ll="eza -la --icons --color=always --group-directories-first --git"
    alias la="eza -a --icons --color=always --group-directories-first"
    alias lt="eza --tree --icons --color=always --level=2"
else
    alias ls="ls --color=auto"
    alias ll="ls -la --color=auto"
    alias la="ls -A --color=auto"
fi

# ── History ──
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS
ZSH_EOF
ok ".zshrc written"

# Set zsh as default
info "Setting Zsh as default shell..."
chsh -s "$(which zsh)" 2>/dev/null || warn "Run manually: chsh -s \$(which zsh)"
ok "Default shell: zsh"


# ══════════════════════════════════════
# DONE!
# ══════════════════════════════════════
echo ""
echo -e "${R}${B}"
echo "  ╔════════════════════════════════════════════════════════════╗"
echo "  ║                                                            ║"
echo "  ║   ⚔️  SAMURAI TERMINAL — SETUP COMPLETE!                  ║"
echo "  ║                                                            ║"
echo "  ╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "  ${B}What you got:${NC}"
echo -e "  ⚔️  ${C}刀${NC} Katana sword prompt on every enter"
echo -e "  🎨  ${C}Anime girl${NC} on right side in fastfetch"
echo -e "  🖼️  ${C}Red anime wallpaper${NC} as terminal background"
echo -e "  📦  ${C}Colored boxes${NC} with system info"
echo -e "  ⚡  ${C}Starship${NC} powerline prompt"
echo -e "  🔍  ${C}Atuin${NC} smart history (Ctrl+R)"
echo -e "  📂  ${C}eza${NC} colorful ls with icons"
echo -e "  ✨  ${C}Cursor trail${NC} animation"
echo ""
echo -e "  ${B}Ab ye karo:${NC}"
echo ""
echo -e "  ${C}1.${NC} Ye terminal band karo"
echo -e "  ${C}2.${NC} Activities mein ${B}'Kitty'${NC} search karke kholo"
echo -e "     ya: ${B}~/.local/bin/kitty &${NC}"
echo -e "  ${C}3.${NC} ${B}F11${NC} = Fullscreen"
echo ""
echo -e "  ${B}Shortcuts:${NC}"
echo -e "  • ${B}F11${NC}              → Fullscreen"
echo -e "  • ${B}Ctrl+Shift+=${NC}     → Font size +"
echo -e "  • ${B}Ctrl+Shift+-${NC}     → Font size -"
echo -e "  • ${B}Ctrl+Shift+A → M${NC} → Opacity +"
echo -e "  • ${B}Ctrl+Shift+A → L${NC} → Opacity -"
echo ""
echo -e "  ${B}Wallpaper change karna ho:${NC}"
echo -e "  nano ~/.config/kitty/kitty.conf"
echo -e "  ${B}background_image ~/Downloads/YOUR-IMAGE.jpg${NC}"
echo ""
echo -e "  ${B}Tint adjust (wallpaper dark/bright):${NC}"
echo -e "  ${B}background_tint 0.0${NC}  → full original wallpaper"
echo -e "  ${B}background_tint 0.5${NC}  → half dark"
echo -e "  ${B}background_tint 0.8${NC}  → mostly dark"
echo ""
echo -e "  ${B}Config files:${NC}"
echo -e "  • ~/.config/kitty/kitty.conf"
echo -e "  • ~/.config/fastfetch/sample_2.jsonc"
echo -e "  • ~/.config/fastfetch/assets/jedi.png"
echo -e "  • ~/.config/starship.toml"
echo -e "  • ~/.zshrc"
echo ""
echo -e "  ${Y}NOTE: Anime image sirf Kitty mein dikhegi, GNOME Terminal mein nahi.${NC}"
echo ""
