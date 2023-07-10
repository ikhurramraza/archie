local theme = "catppuccin"

local Catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = theme == "catppuccin",
  lazy = false,
  priority = 1000,
  config = function(plugin)
    vim.g.catppuccin_flavour = "mocha"
    require(plugin.name).setup({ no_italic = true })
    vim.api.nvim_command("colorscheme catppuccin")
  end,
}

local Dracula = {
  "dracula/vim",
  name = "dracula",
  enabled = theme == "dracula",
  lazy = false,
  priority = 1000,
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
