local theme = "cyberdream"

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
    vim.api.nvim_command("highlight Todo gui=none guibg=none guifg=#6c7086")
  end,
}

local Cyberdream = {
  "scottmckendry/cyberdream.nvim",
  name = "cyberdream",
  enabled = theme == "cyberdream",
  lazy = false,
  priority = 1000,
  config = function(plugin)
    require(plugin.name).setup({
      transparent = true
      })
    vim.cmd("colorscheme cyberdream")
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

return { Catppuccin, Cyberdream, Dracula }
