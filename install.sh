#!/usr/bin/env bash
set -euo pipefail

DOTDIR="$HOME/PROJECTS/Arch-Dotfiles"
CONFDIR="$HOME/.config"

declare -a FOLDERS=(fastfetch wayle)

for folder in "${FOLDERS[@]}"; do
    src="$DOTDIR/$folder"
    dst="$CONFDIR/$folder"

    if [ ! -d "$src" ]; then
        echo "[SKIP] $src does not exist"
        continue
    fi

    if [ -L "$dst" ]; then
        rm "$dst"
        echo "[RELINK] $dst -> $src"
    elif [ -d "$dst" ]; then
        mv "$dst" "${dst}.bak.$(date +%s)"
        echo "[BACKUP] $dst"
    else
        echo "[LINK] $dst -> $src"
    fi

    ln -sf "$src" "$dst"
done

# Hyprland 0.55+ reads ~/.config/hypr/hyprland.lua (hyprlang .conf is legacy)
mkdir -p "$CONFDIR/hypr"
ln -sfn "$DOTDIR/hyprland/hyprland.lua" "$CONFDIR/hypr/hyprland.lua"
ln -sfn "$DOTDIR/hyprland/hyprlock.conf" "$CONFDIR/hypr/hyprlock.conf"
ln -sfn "$DOTDIR/hyprland/scripts" "$CONFDIR/hypr/scripts"
echo "[LINK] $CONFDIR/hypr/hyprland.lua -> $DOTDIR/hyprland/hyprland.lua"
echo "[LINK] $CONFDIR/hypr/hyprlock.conf -> $DOTDIR/hyprland/hyprlock.conf"
echo "[LINK] $CONFDIR/hypr/scripts -> $DOTDIR/hyprland/scripts"

echo ""
echo "Done. Symlinks installed from $DOTDIR to $CONFDIR"
