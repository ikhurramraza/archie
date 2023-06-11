return {
  "AckslD/muren.nvim",
  config = true,
  cmd = "MurenToggle",
  keys = {
    {
      "<leader>om",
      vim.cmd.MurenToggle,
      silent = true,
      desc = "Toggle Muren",
    },
  },
}
