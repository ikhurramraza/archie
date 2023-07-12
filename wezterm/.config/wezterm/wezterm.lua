local wezterm = require("wezterm")
local color_schemes = require("color_schemes")

local M = {
  color_scheme = "Catppuccin Mocha Custom",
  color_schemes = color_schemes,
  disable_default_key_bindings = true,
  font = wezterm.font("Monaco Nerd Font Mono"),
  font_size = 16,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",

  keys = {
    {
      key = "f",
      mods = "SHIFT|CTRL",
      action = wezterm.action.ToggleFullScreen,
    },
    {
      key = "v",
      mods = "SHIFT|CTRL",
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  },
}

return M
