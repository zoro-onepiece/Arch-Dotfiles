# Arch-Dotfiles

Personal Hyprland (Wayland) setup for a Lenovo ThinkBook 14 G6 IRL running Arch Linux.

## What's inside

| Path | Description |
|------|-------------|
| `hyprland/` | Hyprland 0.56+ config in **Lua** (`hyprland.lua` is the source of truth), plus `hyprlock.conf` |
| `hyprland/scripts/` | Custom scripts for low battery notifications and Namaz (Prayer) timings |
| `wayle/` | [Wayle](https://github.com/wayle-rs/wayle) shell (status bar) config — workspaces, clock, cpu, ram, network, battery, night light toggle |
| `fastfetch/` | fastfetch config + ASCII art logo |
| `install.sh` | Symlinks everything into `~/.config` |

## Features

- **Function keys**: volume (wpctl), brightness (brightnessctl), media (playerctl)
- **Night light**: hyprsunset toggle button in the bar (4000K warm), left-click on/off, right-click for nmtui-style networking lives on the network module
- **WiFi module**: NetworkManager dropdown on left-click, `nmtui` on right-click
- **Clipboard history**: `cliphist` + `wofi`
- **Screenshots**: region select via `grim` + `slurp` to clipboard
- **Lock Screen**: Beautifully configured `hyprlock` integration
- **Custom Scripts**: Background alerts for low battery (15%, 10%, 5%) and dynamic Namaz (prayer) timings fetching
- Pastel Catppuccin Macchiato/Mocha theme across the bar

## Install

```bash
git clone https://github.com/zoro-onepiece/Arch-Dotfiles ~/PROJECTS/Arch-Dotfiles
cd ~/PROJECTS/Arch-Dotfiles
./install.sh
```

> If you clone somewhere else, update `DOTDIR` at the top of `install.sh`.

## Keybinds (Super = Windows key)

| Key | Action |
|-----|--------|
| `Super + Enter` / `Super + Q` | Terminal (kitty) |
| `Super + C` | Close window |
| `Super + E` | File manager (dolphin) |
| `Super + R` / `Super + Space` | App launcher (rofi) |
| `Super + V` | Clipboard history |
| `Super + Shift + S` | Region screenshot to clipboard |
| `Super + F` | Fullscreen |
| `Super + 1..9` / `Super + Shift + 1..9` | Switch / move window to workspace |
| `Super + mouse` | Drag to move, right-drag to resize |
| Volume / brightness / media keys | wpctl / brightnessctl / playerctl |

## Dependencies

`hyprland` `hyprlock` `wayle` `kitty` `rofi` `wofi` `dolphin` `swww` `cliphist` `wl-clipboard` `grim` `slurp` `brightnessctl` `playerctl` `wireplumber` `hyprsunset` `networkmanager` `polkit-kde-agent` `libnotify` `python`

---

## 🤖 AI Setup Prompt

If you are using an AI agent to help set up your system with these dotfiles, just copy and paste the prompt below to your AI assistant:

> **"Please help me install and configure my Arch Linux system using the dotfiles from https://github.com/zoro-onepiece/Arch-Dotfiles. Start by cloning the repository and running the `install.sh` script to set up the symlinks. Then, review the 'Dependencies' section in the README and use `pacman` or my AUR helper (like `yay` or `paru`) to install all the required packages (including `hyprland`, `hyprlock`, `wayle`, `libnotify`, `python`, etc.). Ensure `wayle` and the custom battery/namaz scripts are set up correctly. Guide me through the entire setup step-by-step until my Hyprland environment is fully functional."**
