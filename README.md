<h1 align="center">⚔️ Samurai Terminal</h1>

<p align="center">
  <b>Transform your boring Linux terminal into a stunning Samurai-themed powerhouse — in one command.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Zsh-blue?style=for-the-badge&logo=gnu-bash" />
  <img src="https://img.shields.io/badge/Terminal-Kitty-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Prompt-Starship-purple?style=for-the-badge&logo=starship" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Platform-Linux-yellow?style=for-the-badge&logo=linux" />
</p>

<p align="center">
  <img src="screenshots/demo.png" alt="Samurai Terminal Demo" width="800"/>
</p>

---

## 🎬 Inspired By

This project is inspired by the video **["Give Your Linux Terminal A Stunning Makeover"](https://youtu.be/ffmm80_Cii4)** by **[It's FOSS](https://www.youtube.com/@itsfoss)**, enhanced with a Samurai/Anime aesthetic, katana (刀) prompt, and a red wallpaper theme.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| ⚔️ **刀 Katana Prompt** | Sword symbol on every command — red on success, yellow on error |
| 🎨 **Anime Fastfetch** | System info with anime character image and colored boxes |
| 🖼️ **Wallpaper Background** | Anime wallpaper as your terminal background |
| 🚀 **Starship Prompt** | Colorful powerline prompt with OS icon, git info, time |
| ✨ **Cursor Trail** | Glowing animated cursor trail effect |
| 🔍 **Smart History** | Atuin — searchable shell history with Ctrl+R |
| 📂 **Colorful ls** | eza — modern ls replacement with icons and git status |
| 🔤 **Nerd Fonts** | JetBrainsMono, FiraCode, CascadiaCode with icons |
| ⌨️ **Shortcuts** | F11 fullscreen, font scaling, opacity control |
| 🪟 **Window Buttons** | Minimize, maximize, close buttons stay visible |

---

## 📦 What Gets Installed

| Tool | Purpose |
|------|---------|
| [Kitty](https://sw.kovidgoyal.net/kitty/) | GPU-accelerated terminal emulator (latest version) |
| [Zsh](https://www.zsh.org/) | Modern shell with plugins |
| [Starship](https://starship.rs/) | Cross-shell customizable prompt |
| [Fastfetch](https://github.com/fastfetch-cli/fastfetch) | System info display with image support |
| [Atuin](https://atuin.sh/) | Magical shell history search |
| [eza](https://github.com/eza-community/eza) | Modern ls replacement with icons |
| [Nerd Fonts](https://www.nerdfonts.com/) | JetBrainsMono, FiraCode, CascadiaCode |
| Zsh Plugins | autosuggestions, syntax-highlighting, autocomplete |

---

## 🚀 Quick Install

```bash
git clone https://github.com/Satishchoudhary94/samurai-terminal.git
cd samurai-terminal
chmod +x samurai-terminal.sh && ./samurai-terminal.sh
```

The script handles everything automatically. Just sit back and watch.

After installation, close your current terminal and open **Kitty** from your application menu.

---

## 📸 Screenshots

<p align="center">
  <img src="screenshots/fastfetch-preview.png" alt="Fastfetch Preview" width="700"/>
</p>

> Add your own screenshots to the `screenshots/` folder!

---

## 📋 Manual Installation (Step by Step)

If you prefer doing it yourself, follow these steps in order.

### Step 1 — Install Nerd Fonts

```bash
mkdir -p ~/.local/share/fonts

wget -O /tmp/JBMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o /tmp/JBMono.zip -d ~/.local/share/fonts/JetBrainsMono
rm /tmp/JBMono.zip

wget -O /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o /tmp/FiraCode.zip -d ~/.local/share/fonts/FiraCode
rm /tmp/FiraCode.zip

fc-cache -fv
```

### Step 2 — Install Zsh and Plugins

```bash
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete ~/zsh-autocomplete
chsh -s $(which zsh)
```

### Step 3 — Install Starship Prompt

```bash
curl -sS https://starship.rs/install.sh | sh
```

Copy the config:

```bash
mkdir -p ~/.config
cp configs/starship/starship.toml ~/.config/starship.toml
```

### Step 4 — Install Kitty Terminal (Latest Version)

> **Important:** Do not install Kitty from apt. The apt version is outdated and missing key features like cursor trail and image support.

```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/bin/kitty
ln -sf ~/.local/kitty.app/bin/kitten ~/.local/bin/kitten
```

Copy the config:

```bash
mkdir -p ~/.config/kitty
cp configs/kitty/kitty.conf ~/.config/kitty/kitty.conf
```

### Step 5 — Install Fastfetch

```bash
# Ubuntu 24.10+
sudo apt install fastfetch

# Ubuntu 22.04 / 24.04
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
sudo apt update
sudo apt install fastfetch
```

Copy the config and anime image:

```bash
mkdir -p ~/.config/fastfetch/assets
cp configs/fastfetch/sample_2.jsonc ~/.config/fastfetch/sample_2.jsonc
cp configs/fastfetch/sample_2.jsonc ~/.config/fastfetch/config.jsonc
cp configs/fastfetch/assets/jedi.png ~/.config/fastfetch/assets/jedi.png
```

### Step 6 — Install Atuin

```bash
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
```

### Step 7 — Install eza

```bash
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install -y eza
```

### Step 8 — Install imagemagick

```bash
sudo apt install -y imagemagick
```

### Step 9 — Download Wallpaper

Download the anime wallpaper and save it to `~/Downloads/`:

🔗 **[Anime Girl Katana Tattoo 8K](https://www.uhdpaper.com/2024/01/anime-girl-katana-tattoo-8k-228a.html)**

You can also use any wallpaper you like. Just update the path in `~/.config/kitty/kitty.conf`:

```
background_image ~/Downloads/your-wallpaper.jpg
```

### Step 10 — Configure .zshrc

Create or replace your `~/.zshrc` with the following:

```bash
# PATH
export PATH="$HOME/.local/bin:$HOME/.atuin/bin:$PATH"

# Fastfetch on terminal launch
if command -v fastfetch &>/dev/null; then
    fastfetch -c ~/.config/fastfetch/sample_2.jsonc
fi

# Zsh plugins
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh ] && source ~/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Starship prompt
eval "$(starship init zsh)"

# Atuin history
eval "$(atuin init zsh)"

# Aliases
alias ls="eza --icons --color=always --group-directories-first"
alias ll="eza -la --icons --color=always --group-directories-first --git"
alias la="eza -a --icons --color=always --group-directories-first"
alias lt="eza --tree --icons --color=always --level=2"
```

### Step 11 — Launch Kitty

Close your current terminal and open Kitty:

```bash
~/.local/bin/kitty &
```

Or search for **Kitty** in your application menu. Enjoy your new terminal! ⚔️

---

## ⌨️ Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `F11` | Toggle fullscreen |
| `Ctrl+Shift+=` | Increase font size |
| `Ctrl+Shift+-` | Decrease font size |
| `Ctrl+Shift+A` then `M` | Increase opacity |
| `Ctrl+Shift+A` then `L` | Decrease opacity |
| `Ctrl+R` | Smart history search (Atuin) |

---

## 🎨 Customization

### Change Wallpaper

Edit `~/.config/kitty/kitty.conf` and update this line:

```
background_image ~/path/to/your/wallpaper.jpg
```

### Adjust Wallpaper Darkness

Change the `background_tint` value in `~/.config/kitty/kitty.conf`:

```
background_tint 0.0   → Full original wallpaper (no darkening)
background_tint 0.5   → Half dark overlay
background_tint 0.8   → Mostly dark (easier to read text)
```

### Change Kitty Color Theme

```bash
kitty +kitten themes
```

Recommended themes: **Catppuccin Mocha**, **Tokyo Night**, **Dracula**

### Change the Prompt Symbol

Edit `~/.config/starship.toml` and find the `[character]` section:

```toml
[character]
success_symbol = "[刀](bold red)"     # Katana (default)
# success_symbol = "[⚔](bold red)"   # Crossed swords
# success_symbol = "[❯](bold red)"   # Arrow
# success_symbol = "[➜](bold red)"   # Pointed arrow
```

### Show or Hide Window Buttons

Edit `~/.config/kitty/kitty.conf`:

```
hide_window_decorations no    → Show buttons (minimize, maximize, close)
hide_window_decorations yes   → Borderless clean look (no buttons)
```

---

## 📁 Repository Structure

```
samurai-terminal/
├── install.sh                          # Automated one-click installer
├── uninstall.sh                        # Revert everything to defaults
├── README.md
├── LICENSE
├── .gitignore
├── configs/
│   ├── kitty/
│   │   └── kitty.conf                  # Kitty terminal configuration
│   ├── starship/
│   │   └── starship.toml               # Starship prompt with 刀 katana
│   └── fastfetch/
│       ├── sample_2.jsonc              # Fastfetch layout with colored boxes
│       └── assets/
│           └── jedi.png                # Anime character image
└── screenshots/
    ├── demo.png                        # Main terminal screenshot
    └── fastfetch-preview.png           # Fastfetch output preview
```

---

## 🖥️ Supported Distributions

| Distribution | Status |
|--------------|--------|
| Ubuntu 22.04+ | ✅ Tested |
| Ubuntu 24.04+ | ✅ Tested |
| Debian 12+ | ✅ Supported |
| Fedora 38+ | ✅ Supported |
| Arch Linux | ✅ Supported |
| Linux Mint | ✅ Supported |
| Pop!_OS | ✅ Supported |

---

## 🗑️ Uninstall

To revert your terminal back to defaults:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This removes configuration files and resets your shell to Bash. Installed packages are not removed automatically.

To fully remove all packages:

```bash
sudo apt remove zsh kitty fastfetch
rm -rf ~/.local/kitty.app
```

---

## 🤝 Contributing

Contributions are welcome! If you have a new theme, a bug fix, or an improvement:

1. Fork this repository
2. Create your feature branch: `git checkout -b feature/my-theme`
3. Commit your changes: `git commit -m 'Add my custom theme'`
4. Push to the branch: `git push origin feature/my-theme`
5. Open a Pull Request

---

## ⭐ Support

If this project helped you, please consider giving it a **star** ⭐ — it helps others discover it!

---

## 📝 Credits

- Inspired by **[It's FOSS](https://youtube.com/@itsfoss)** — [Give Your Linux Terminal A Stunning Makeover](https://youtu.be/ffmm80_Cii4)
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/) by Kovid Goyal
- [Starship Prompt](https://starship.rs/)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [Atuin](https://atuin.sh/)
- [eza](https://github.com/eza-community/eza)
- [Nerd Fonts](https://www.nerdfonts.com/)
- Anime artwork from [UHDPaper](https://www.uhdpaper.com/)

---

<p align="center">
  Made with ⚔️ by <a href="https://github.com/YOUR_USERNAME">Satish</a>
</p>
