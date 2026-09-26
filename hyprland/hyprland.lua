-- Hyprland configuration (Hyprland 0.55+ Lua format)
-- Source of truth: ~/PROJECTS/Arch-Dotfiles/hyprland/hyprland.lua
-- Symlinked to ~/.config/hypr/hyprland.lua by install.sh

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("wayle shell")
    hl.exec_cmd("swww-daemon")
    hl.exec_cmd("~/.config/hypr/scripts/battery-notify.sh &")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 4,
        gaps_out    = 6,
        border_size = 2,

        col = {
            active_border   = "rgba(969db2ff)",
            inactive_border = "rgba(3b3b3bff)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 6,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        force_default_wallpaper      = 0,
        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,
        vrr                          = 1,
    },
})

-- Single low-speed curve; blur/shadows off to stay lightweight under 8GB RAM
hl.curve("easeOut", { type = "bezier", points = { {0.25, 0.8}, {0.5, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 2, bezier = "easeOut" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 2, bezier = "easeOut" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2, bezier = "easeOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "easeOut" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },
})

------------------
---- GESTURES ----
------------------

-- 3-finger horizontal swipe = workspace switch
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Applications & Windows
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Open clipboard history with Super + V
-- (pipes need an explicit shell wrapper: Hyprland execs the string directly)
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("sh -c 'cliphist list | wofi --dmenu | cliphist decode | wl-copy'"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Region screenshot to clipboard (requires grim, slurp, wl-clihlpboard)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('sh -c \'grim -g "$(slurp)" - | wl-copy\''))

-- Navigation
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces (1-9)
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Mouse bindings
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------
---- FUNCTION KEYS -------
--------------------------

-- Volume (repeat while held)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Brightness (repeat while held)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
