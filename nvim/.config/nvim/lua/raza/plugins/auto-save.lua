return {
  "907th/vim-auto-save",
  cmd = "AutoSaveToggle",
  init = function()
    vim.g.auto_save = 1
    vim.g.auto_save_silent = 1
  end,
  keys = {
    {
      "<leader>os",
      vim.cmd.AutoSaveToggle,
      silent = true,
      desc = "Toggle auto saving",
    },
  },
}
