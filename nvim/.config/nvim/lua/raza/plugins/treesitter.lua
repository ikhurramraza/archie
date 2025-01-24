return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- TODO: Revert to original repo once #42 is merged
    dependencies = { "metiulekm/nvim-treesitter-endwise" },
    event = "VeryLazy",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      endwise = {
        enable = true,
      },
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
        "comment",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "gpg",
        "html",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nu",
        "rbs",
        "ruby",
        "rust",
        "sql",
        "ssh_config",
        "tmux",
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
