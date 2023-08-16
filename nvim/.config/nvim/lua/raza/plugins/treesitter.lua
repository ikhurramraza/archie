return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "+",
          node_incremental = "+",
          node_decremental = "-",
        },
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
  },

  {
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSHighlightCapturesUnderCursor",
      "TSNodeUnderCursor",
      "TSPlaygroundToggle",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { enable = false },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    keys = {
      {
        "<leader>oc",
        vim.cmd.TSContextToggle,
        silent = true,
        desc = "Toggle code context",
      },
    },
  },
}
