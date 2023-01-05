local theme = "catppuccin"

if theme == "catppuccin" then
  vim.g.catppuccin_flavour = "macchiato"
  require("catppuccin").setup()
  vim.api.nvim_command("colorscheme catppuccin")
elseif theme == "dracula" then
  vim.g.dracula_italic = 0
  vim.g.dracula_inverse = 0

  vim.api.nvim_command("colorscheme dracula")
  vim.api.nvim_command("highlight DraculaBoundary   guibg=none")
  vim.api.nvim_command("highlight DraculaTodo       guifg=#6272A4")
  vim.api.nvim_command("highlight DraculaDiffDelete guibg=none ctermbg=none")
  vim.api.nvim_command("highlight DraculaComment    cterm=italic gui=italic")
end