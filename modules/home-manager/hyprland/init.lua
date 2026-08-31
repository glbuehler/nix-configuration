local vars = require("generated.variables")

local mod = vars.mod or "SUPER"

local dms = vars.dms or "dms"
local wpctl = vars.wpctl or "wpctl"
local hyprshot = vars.hyprshot or "hyprshot"
local terminal = vars.terminal or "ghostty"
local playerctl = vars.playerctl or "playerctl"

hl.config({
    general = {
        allow_tearing = false,
        layout = "dwindle",
        gaps_in = 6,
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border = "rgba(808080ff)",
            inactive_border = "rgba(595959ff)",
        },
    },
    dwindle = { preserve_split = true },
    decoration = {
        blur = { enabled = false, },
        shadow = { enabled = false, },
        rounding = 6,
        -- inactive_opacity = 0.7,
    },
    animations = {
        enabled = true,
    },
    input = {
        kb_layout = "de",
        repeat_delay = 250,
        repeat_rate = 40,

        accel_profile = "flat",

        follow_mouse = 1,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

hl.on("hyprland.start", function()
    if vars.auto_start then
        for key, value in pairs(vars.auto_start) do
            if key:sub(0, 2) == "ws" then
                for _, cmd in ipairs(value) do
                    hl.exec_cmd(cmd, { workspace = key:sub(3) .. " silent" })
                end
            end
        end
    end
    hl.exec_cmd(dms .. " run")
end)


hl.window_rule({
    match = {
        class = "firefox",
    },
    workspace = "2 silent",
})

hl.window_rule({
    match = {
        class = "discord",
    },
    workspace = "10 silent",
})

-- workspace management with 1...9, 0 keys
for ws = 1, 10, 1 do
    -- 0 key for workspace 10
    local key = (ws == 10) and 0 or ws
    hl.bind(mod .. "+" .. key, hl.dsp.focus({ workspace = ws }))
    hl.bind("SHIFT +" .. mod .. "+" .. key, hl.dsp.window.move({ monitor = "current", workspace = ws }))
end

-- vi like movement with hjkl
for key, dir in pairs({ h = "l", j = "d", k = "u", l = "r" }) do
    -- move focus
    hl.bind(mod .. "+" .. key, hl.dsp.focus({ direction = dir }))
    -- move window within workspace
    hl.bind("SHIFT +" .. mod .. "+" .. key, hl.dsp.window.move({ direction = dir }))
end


-- other keyboard functions
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n1 set +8%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n1 set 8%-"))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(wpctl .. " set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(wpctl .. " set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(wpctl .. " set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(playerctl .. " play-pause"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(playerctl .. " stop"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(playerctl .. " previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(playerctl .. " next"))
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd(dms .. " ipc lock lock"))

-- hyprshot
hl.bind(mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m window -m active --clipboard-only"))
hl.bind("SHIFT + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m window -m active --output-folder ~/Pictures"))
hl.bind("CTRL + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m region --clipboard-only"))
hl.bind("CTRL + SHIFT + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m region --output-folder ~/Pictures"))

-- terminal
hl.bind(mod .. " + return", hl.dsp.exec_cmd(terminal))
-- dms app picker
hl.bind(mod .. " + d", hl.dsp.exec_cmd(dms .. " ipc call spotlight toggle"))

-- closing windows
hl.bind(mod .. " + q", hl.dsp.window.close({ window = "activewindow" }))
hl.bind("SHIFT + " .. mod .. " + q", hl.dsp.window.kill("activewindow"))

-- mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind("SHIFT + " .. mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- floating windows
hl.bind(mod .. " + f", hl.dsp.window.float({
    window = "activewindow",
    action = "toggle",
}))
-- fullscreen
hl.bind("SHIFT + " .. mod .. " + f", hl.dsp.window.fullscreen({
    window = "activewindow",
    action = "toggle",
    mode = "fullscreen",
}))

local ease = "ease-in-out"
hl.curve(
    ease,
    {
        type = "bezier",
        points = { { 0.42, 0.0 }, { 0.58, 1.0 } },
    }
)

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 1,
    bezier = ease,
})

local ok, host_config = pcall(require, "host_config")
if ok then
    host_config(hl)
end
