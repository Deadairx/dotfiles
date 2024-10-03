local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font "Comic Mono"
config.font_size = 18.0
config.window_background_opacity = 0.8

-- config.color_scheme = 'Github'
config.window_background_gradient = {
  colors = { '#001233', 'black' },
  -- colors = { 'black' },
  -- preset = "CubeHelixDefault",
  orientation = {
    Radial = {
      -- Specifies the x coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the X dimension.
      cx = 0.0,

      -- Specifies the y coordinate of the center of the circle,
      -- in the range 0.0 through 1.0.  The default is 0.5 which
      -- is centered in the Y dimension.
      cy = 0.0,

      -- Specifies the radius of the notional circle.
      -- The default is 0.5, which combined with the default cx
      -- and cy values places the circle in the center of the
      -- window, with the edges touching the window edges.
      -- Values larger than 1 are possible.
      radius = 1.25,
    },
  },
}

return config
