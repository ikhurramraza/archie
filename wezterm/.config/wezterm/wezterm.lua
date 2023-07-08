local wezterm = require("wezterm")

local custom_catppuccin_mocha_color_scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

-- Fix for gitui and joshuto coloring
custom_catppuccin_mocha_color_scheme.ansi[5] = "679DD6"
custom_catppuccin_mocha_color_scheme.ansi[8] = "CBD3EF"
custom_catppuccin_mocha_color_scheme.brights[4] = "D7C08D"
custom_catppuccin_mocha_color_scheme.brights[8] = "FFFFFF"

-- Fix for irb autocomplete menu coloring
custom_catppuccin_mocha_color_scheme.ansi[7] = "679DD6"

local M = {
  color_scheme = "Catppuccin Mocha Custom",
  color_schemes = { ["Catppuccin Mocha Custom"] = custom_catppuccin_mocha_color_scheme },
  disable_default_key_bindings = false,
  font = wezterm.font("Monaco Nerd Font Mono"),
  font_size = 16,
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "NONE",
}

return M
