return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = { icons = { mappings = false } },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
}
