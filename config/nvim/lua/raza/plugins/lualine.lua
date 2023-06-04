return {
  "nvim-lualine/lualine.nvim",
  dependencies = "kyazdani42/nvim-web-devicons",
  config = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {},
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    extensions = {
      "quickfix",
    },
    options = {
      disabled_filetypes = { "undotree" },
    },
  },
}
