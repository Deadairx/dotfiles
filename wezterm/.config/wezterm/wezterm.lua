local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font "Comic Mono"
config.font_size = 24.0
config.window_background_opacity = 0.8

config.colors = {
  background = '#202020',
}

-- config.color_scheme = 'Github'
-- config.window_background_gradient = {
--   colors = { 'black', 'gray', '#00a213', 'black' },
--   -- colors = { 'black' },
--   -- preset = "CubeHelixDefault",
--   orientation = 'Vertical',
--   -- orientation = { Radial = { cx = 0.75, cy = 0.5, radius = 1.0, }, },
--   blend = 'LinearRgb',
-- }

return config
