-- Disable line numbers in a terminal
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  command = [[setlocal formatoptions-=c formatoptions-=r formatoptions-=o]],
})

-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 50 })
  end,
})
