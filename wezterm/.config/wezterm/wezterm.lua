local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font "Comic Mono"
config.font_size = 20.0
-- config.window_background_opacity = 0.8
config.window_background_opacity = 1.0

-- config.color_scheme = 'Github'
config.window_background_gradient = {
  colors = { '#005233', '#000203', '#005233' },
  -- colors = { 'black' },
  -- preset = "CubeHelixDefault",
  orientation = {
    Radial = {
      cx = 0.75,
      cy = 1.05,
      radius = 1.2,
    },
  },
}


return config
