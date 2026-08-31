return function(hl)
    hl.config({
        input = {
            sensitivity = -0.8,
        },
    })

    -- main monitor
    hl.monitor({
        output = "DP-1",
        mode = "preferred",
        position = "auto",
        scale = 1,
    })

    -- additional hdmi monitor
    hl.monitor({
        output = "HDMI-A-1",
        mode = "preferred",
        position = "auto-right",
        scale = "auto",
    })
end
