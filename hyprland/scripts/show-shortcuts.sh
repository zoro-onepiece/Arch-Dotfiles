#!/bin/bash
cat << 'IN' > /tmp/hyprland-shortcuts.txt
Super + Enter        : Terminal
Super + E            : File Manager
Super + R or Space   : App Menu (Rofi)
Super + Q            : Kill Window
Super + C            : Close Window
Super + V            : Clipboard History
Super + F            : Fullscreen
Super + L            : Lock Screen
Super + Shift + S    : Screenshot region

--- Window Management ---
Super + Arrow Keys   : Move focus
Super + Shift + Arrow: Swap window in current workspace
Super + 1-9          : Switch to Workspace 1-9
Super + Shift + 1-9  : Move window to Workspace 1-9
Super + Mouse Drag   : Move floating window
Super + Mouse Resize : Resize window

--- Media ---
Vol Up/Down/Mute     : Control audio volume
Brightness Up/Down   : Control screen brightness
Media Keys           : Play/Pause, Next, Previous

--- System ---
Super + M            : Exit Hyprland
Super + /            : Show these shortcuts
IN

# Use rofi to display, exit on selection or escape
rofi -dmenu -i -p "Shortcuts" -theme-str 'listview { lines: 25; } window { width: 600px; }' < /tmp/hyprland-shortcuts.txt
