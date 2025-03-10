return {
  "yetone/avante.nvim",
  version = false,
  cmd = { "AvanteAsk", "AvanteChat", "AvanteToggle" },
  keys = { "<leader>aa" },
  opts = { provider = "copilot" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "zbirenbaum/copilot.lua",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
