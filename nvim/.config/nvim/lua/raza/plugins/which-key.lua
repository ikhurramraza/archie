return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = { icons = { mappings = false } },
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
}
