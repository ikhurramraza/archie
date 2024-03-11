return {
  "pocco81/auto-save.nvim",
  event = "VeryLazy",
  config = true,
  keys = {
    { "<leader>os", vim.cmd.ASToggle, desc = "Toggle auto saving" },
  },
}
