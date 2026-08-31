return function(hl)
    hl.config({
        input = {
            sensitivity = -0.1,
            touchpad = {
                natural_scroll = true,
            },
        },
    })

    -- main built-in screen
    hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "auto",
        scale = 1,
    })

    -- hdmi port
    hl.monitor({
        output = "HDMI-A-1",
        mode = "preferred",
        position = "auto-left",
        scale = "auto",
    })
end
