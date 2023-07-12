local wezterm = require("wezterm")
local color_schemes = require("color_schemes")

local M = {
  color_scheme = "Catppuccin Mocha Custom",
  color_schemes = color_schemes,
  disable_default_key_bindings = false,
  font = wezterm.font("Monaco Nerd Font Mono"),
  font_size = 16,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
}

return M
