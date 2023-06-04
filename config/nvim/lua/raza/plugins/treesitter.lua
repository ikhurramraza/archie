return {
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  main = "nvim-treesitter.configs",
  config = {
    highlight = {
      enable = true,
    },
    ensure_installed = {
      "bash",
      "html",
      "ini",
      "javascript",
      "json",
      "lua",
      "make",
      "ruby",
      "rust",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
}
