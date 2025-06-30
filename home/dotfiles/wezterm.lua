local wezterm = require('wezterm')

return {
    term = 'wezterm',
    default_prog = { 'bash', '-i' },
    default_cursor_style = 'SteadyBlock',
    cursor_blink_rate = 0,
    color_scheme = 'tokyonight_moon',
    font = wezterm.font({
        family = 'JetBrains Mono',
        weight = 'Medium',
    }),
    font_size = 18.0,
    line_height = 1.05,
    underline_thickness = '2pt',
    enable_tab_bar = false,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
}
