return {
  "Wansmer/treesj",
  dependencies = "nvim-treesitter",
  cmd = { "TSJToggle", "TSJJoin", "TSJSplit" },
  opts = { use_default_keymaps = false },
  keys = {
    {
      "<leader>m",
      vim.cmd.TSJToggle,
      silent = true,
      desc = "Split or Join",
    },
  },
}
