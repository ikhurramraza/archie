return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  init = function()
    vim.opt.backup = false
    vim.opt.undofile = true
    vim.opt.swapfile = false
    vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
  end,
  config = function()
    vim.g.undotree_WindowLayout = 3
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_SetFocusWhenToggle = 1
  end,
  keys = {
    {
      "<leader>ou",
      vim.cmd.UndotreeToggle,
      silent = true,
      desc = "Toggle UndoTree",
    },
  },
}
