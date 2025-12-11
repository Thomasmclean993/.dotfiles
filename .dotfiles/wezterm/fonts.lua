local wezterm = require("wezterm")

local M = {}

function M.setup(config)
    config.font = wezterm.font_with_fallback({
        {
            family = "GohuFont 14 Nerd Font",
        },
        {
            family = "FiraMono Nerd Font",
        },
        {
            family = "IosevkaTerm NFM",
        },
        {
            family = "Hack Nerd Font",
        },
    })
    config.font_size = 14
    -- config.underline_thickness = "200%"
    -- config.underline_position = "-3pt"
    -- config.adjust_window_size_when_changing_font_size = false
    config.window_frame = {
        font = wezterm.font({ family = "Japan Rich", weight = "Regular" }),
        font_size = 14,
    }
end

return M
