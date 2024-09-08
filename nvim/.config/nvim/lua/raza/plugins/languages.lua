return {
  -- For nushell config files syntax highlighting
  {
    "LhKipp/nvim-nu",
    ft = "nu",
    opts = { use_lsp_features = false },
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
