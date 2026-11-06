#!/bin/bash
# Region screenshot for Hyprland
# Captures selected region and copies to clipboard
# Supports mnstsh for drawing annotations if available

set -e

OUTPUT="/tmp/ss_raw.png"

# Capture region using grim and slurp
# slurp may cancel if user ESCs or selection is invalid
grim -g "$(slurp)" "$OUTPUT" 2>/dev/null

# Check if capture succeeded (file exists and has content)
if [ ! -f "$OUTPUT" ] || [ ! -s "$OUTPUT" ]; then
    # slurp was cancelled or grim failed
    # Clean up and exit silently
    rm -f "$OUTPUT" 2>/dev/null
    exit 0
fi

# If mnstsh is available, use it for drawing annotations
# mnstsh provides a rich drawing interface arrows, text, etc.
if command -v mnstsh >/dev/null 2>&1; then
    mnstsh -s "$OUTPUT" && exit 0
fi

# Fallback: copy raw screenshot to clipboard
# This also makes it available in cliphist history
wl-copy < "$OUTPUT"

# Also store in cliphist if available, for rich history browsing
if command -v cliphist >/dev/null 2>&1; then
    cliphist store --image "$OUTPUT" 2>/dev/null || true
fi

# Note: Python tkinter drawing window not available (libtk8.6.so missing).
# To enable on-screen drawing/arrows after capture, install:
#   - mnstsh (AUR): provides KDE-like screenshot annotations
#   - Or install python-tk: pacman -S python-tk
# The raw screenshot is still copied to clipboard and cliphist history.

echo "Screenshot captured and copied to clipboard"
exit 0