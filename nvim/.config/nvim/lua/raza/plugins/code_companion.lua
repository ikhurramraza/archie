return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  keys = {
    { "<leader>ac", vim.cmd.CodeCompanionChat, desc = "[CodeCompanion] Open chat" },
    { "<leader>aa", vim.cmd.CodeCompanionActions, desc = "[CodeCompanion] Open actions" },
  },
}
