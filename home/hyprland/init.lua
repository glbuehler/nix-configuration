local vars = require("generated.variables")

local _, host_config = pcall(require, vars.host_config_path)
host_config = host_config or {}

local mod = vars.mod or "SUPER"

local dms = vars.dms or "dms"
local wpctl = vars.wpctl or "wpctl"
local browser = vars.browser or "firefox"
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

        follow_mouse = 1,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
})

if host_config.config then
    hl.config(host_config.config)
end


hl.on("hyprland.start", function()
    hl.exec_cmd(terminal, { workspace = "1" })
    hl.exec_cmd(browser, { workspace = "2 silent" })
    hl.exec_cmd(dms .. " run")

    -- only execute if passed to variables
    if vars.discord ~= nil then
        hl.exec_cmd(vars.discord, { workspace = "10 silent" })
    end
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

hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind("SHIFT + " .. mod .. " + 1", hl.dsp.window.move({ monitor = "current", workspace = 1 }))
hl.bind("SHIFT + " .. mod .. " + 2", hl.dsp.window.move({ monitor = "current", workspace = 2 }))
hl.bind("SHIFT + " .. mod .. " + 3", hl.dsp.window.move({ monitor = "current", workspace = 3 }))
hl.bind("SHIFT + " .. mod .. " + 4", hl.dsp.window.move({ monitor = "current", workspace = 4 }))
hl.bind("SHIFT + " .. mod .. " + 5", hl.dsp.window.move({ monitor = "current", workspace = 5 }))
hl.bind("SHIFT + " .. mod .. " + 6", hl.dsp.window.move({ monitor = "current", workspace = 6 }))
hl.bind("SHIFT + " .. mod .. " + 7", hl.dsp.window.move({ monitor = "current", workspace = 7 }))
hl.bind("SHIFT + " .. mod .. " + 8", hl.dsp.window.move({ monitor = "current", workspace = 8 }))
hl.bind("SHIFT + " .. mod .. " + 9", hl.dsp.window.move({ monitor = "current", workspace = 9 }))
hl.bind("SHIFT + " .. mod .. " + 0", hl.dsp.window.move({ monitor = "current", workspace = 10 }))
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind("SHIFT + " .. mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SHIFT + " .. mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SHIFT + " .. mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SHIFT + " .. mod .. " + j", hl.dsp.focus({ direction = "down" }))

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

hl.bind(mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m window -m active --clipboard-only"))
hl.bind("SHIFT + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m window -m active --output-folder ~/Pictures"))
hl.bind("CTRL + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m region --clipboard-only"))
hl.bind("CTRL + SHIFT + " .. mod .. " + s", hl.dsp.exec_cmd(hyprshot .. " -m region --output-folder ~/Pictures"))

hl.bind(mod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + d", hl.dsp.exec_cmd(dms .. " ipc call spotlight toggle"))

hl.bind(mod .. " + q", hl.dsp.window.close({ window = "activewindow" }))
hl.bind("SHIFT + " .. mod .. " + q", hl.dsp.window.kill("activewindow"))

hl.bind(mod .. " + mouse:272", hl.dsp.window.resize(), { mouse = true })
hl.bind("SHIFT + " .. mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

hl.bind(mod .. " + f", hl.dsp.window.float({
    window = "activewindow",
    action = "toggle",
}))
hl.bind("SHIFT + " .. mod .. " + f", hl.dsp.window.fullscreen({
    window = "activewindow",
    action = "toggle",
    mode = "fullscreen",
}))

for _, m in ipairs(host_config.monitors or {}) do
    hl.monitor(m)
end
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


-- settings = {
--   env = [
--     "XCURSOR_SIZE, 16"
--     "HYPRCURSOR_SIZE,6"
--   ];
--   dwindle = {
--     pseudotile = true;
--   };
--   master.new_status = "master";
--   windowrule = [
--     "suppressevent maximize, class:.*"
--   ];
-- };
