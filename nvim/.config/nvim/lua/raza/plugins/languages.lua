return {
  -- For nushell config files syntax highlighting
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    opts = { use_lsp_features = false },
    build = function()
      vim.cmd.TSInstallSync("nu")
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
