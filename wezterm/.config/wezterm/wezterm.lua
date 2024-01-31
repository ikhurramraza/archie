local wezterm = require("wezterm")
local color_schemes = require("color_schemes")
local env = require("env")

local font_family = "Monaco Nerd Font Mono"

local prog_nushell = { os.getenv("HOME") .. "/.local/share/cargo/bin/nu", "-l" }
local prog_zsh = { "zsh", "-l" }

local M = {
  color_scheme = "Catppuccin Mocha Custom",
  color_schemes = color_schemes,
  disable_default_key_bindings = true,
  font = wezterm.font(font_family),
  font_size = env.os == "Darwin" and 21 or 16,

  default_prog = env.os == "Darwin" and prog_zsh or prog_nushell,

  font_rules = {
    {
      italic = true,
      font = wezterm.font({ family = font_family, italic = false }),
    },
  },

  hide_tab_bar_if_only_one_tab = true,
  window_decorations = env.os == "Darwin" and "TITLE|RESIZE" or "NONE",

  warn_about_missing_glyphs = false,

  keys = {
    { key = "f", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },

    { key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
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
