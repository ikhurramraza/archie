local wezterm = require("wezterm")

local catppuccin_mocha = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

-- Fix for gitui and joshuto coloring
catppuccin_mocha.ansi[5] = "679DD6"
catppuccin_mocha.ansi[8] = "CBD3EF"
catppuccin_mocha.brights[4] = "D7C08D"
catppuccin_mocha.brights[8] = "FFFFFF"

return { ["Catppuccin Mocha Custom"] = catppuccin_mocha }
