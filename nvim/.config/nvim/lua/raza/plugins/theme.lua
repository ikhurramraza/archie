local theme = "catppuccin"

local function disable_italics()
  -- Disable italics since it is broken on Windows Terminal when using Nerd Fonts
  -- See: https://github.com/microsoft/terminal/issues/14094
  vim.api.nvim_command("highlight @parameter  gui=none")
  vim.api.nvim_command("highlight Comment     gui=none")
  vim.api.nvim_command("highlight Conditional gui=none")
end

local Catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = theme == "catppuccin",
  lazy = false,
  priority = 1000,
  init = disable_italics,
  config = function(plugin)
    vim.g.catppuccin_flavour = "mocha"
    require(plugin.name).setup()
    vim.api.nvim_command("colorscheme catppuccin")
  end,
}

local Dracula = {
  "dracula/vim",
  name = "dracula",
  enabled = theme == "dracula",
  lazy = false,
  priority = 1000,
  init = disable_italics,
  config = function()
    vim.g.dracula_italic = 0
    vim.g.dracula_inverse = 0

    vim.api.nvim_command("colorscheme dracula")
    vim.api.nvim_command("highlight DraculaBoundary   guibg=none")
    vim.api.nvim_command("highlight DraculaTodo       guifg=#6272A4")
    vim.api.nvim_command("highlight DraculaDiffDelete guibg=none ctermbg=none")
    vim.api.nvim_command("highlight DraculaComment    cterm=italic gui=italic")
  end,
}

return { Catppuccin, Dracula }
