vim.opt.backup = false
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"

vim.keymap.set("n", "<leader>ou", vim.cmd.UndotreeToggle, { desc = "Toggle Undo Tree" })
