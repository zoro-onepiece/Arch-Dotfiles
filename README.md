# Arch-Dotfiles

Personal Hyprland (Wayland) setup for a Lenovo ThinkBook 14 G6 IRL running Arch Linux.

## What's inside


| Path | Description |
|------|-------------|
| `hyprland/` | Hyprland 0.56+ config in **Lua** (`hyprland.lua` is the source of truth; the `.conf` is legacy), plus `hyprlock.conf` |
| `wayle/` | [Wayle](https://github.com/wayle-rs/wayle) shell (status bar) config — workspaces, clock, cpu, ram, network, battery, night light toggle |
| `fastfetch/` | fastfetch config + ASCII art logo |
| `install.sh` | Symlinks everything into `~/.config` |

## Features

- **Function keys**: volume (wpctl), brightness (brightnessctl), media (playerctl)
- **Night light**: hyprsunset toggle button in the bar (4000K warm), left-click on/off, right-click for nmtui-style networking lives on the network module
- **WiFi module**: NetworkManager dropdown on left-click, `nmtui` on right-click
- **Clipboard history**: `cliphist` + `wofi`
- **Screenshots**: region select via `grim` + `slurp` to clipboard
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

`hyprland` `wayle` `kitty` `rofi` `wofi` `dolphin` `swww` `cliphist` `wl-clipboard` `grim` `slurp` `brightnessctl` `playerctl` `wireplumber` `hyprsunset` `networkmanager` `polkit-kde-agent`
