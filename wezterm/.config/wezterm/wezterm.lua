local wezterm = require("wezterm")
local color_schemes = require("color_schemes")
local env = require("env")

local font_family = "Monaco Nerd Font Mono"

local M = {
  color_scheme = "Catppuccin Mocha Custom",
  color_schemes = color_schemes,
  disable_default_key_bindings = true,
  font = wezterm.font(font_family),
  font_size = 16,

  font_rules = {
    {
      italic = true,
      font = wezterm.font({ family = font_family, italic = false }),
    },
  },

  hide_tab_bar_if_only_one_tab = true,
  window_decorations = env.os == "Darwin" and "TITLE|RESIZE" or "NONE",

  keys = {
    { key = "f", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
    { key = "v", mods = "SHIFT|CTRL", action = wezterm.action.PasteFrom("Clipboard") },

    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  },

  window_padding = {
    left = "6pt",
    right = "2pt",
    top = "6pt",
    bottom = "0pt",
  },
}

return M
