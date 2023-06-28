return {
  { "christoomey/vim-sort-motion", event = "VeryLazy" },
  { "cuducos/yaml.nvim", dependencies = "nvim-telescope/telescope.nvim", ft = "yaml" },
  { "famiu/bufdelete.nvim", event = "VeryLazy" },
  { "jdhao/better-escape.vim", event = "InsertEnter" },
  { "jesseleite/vim-noh", event = "VeryLazy" },
  { "kevinhwang91/nvim-bqf", event = "VeryLazy" },
  { "kylechui/nvim-surround", config = true, event = "VeryLazy" },
  { "metakirby5/codi.vim", cmd = "Codi" },
  { "qpkorr/vim-renamer", cmd = "Renamer" },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "tpope/vim-endwise", event = "VeryLazy" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    cmd = "Copilot",
    keys = {
      {
        "<C-]>",
        "copilot#Accept('<CR>')",
        mode = "i",
        expr = true,
        silent = true,
        replace_keycodes = false,
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    config = true,
    keys = { "gbc", "gcA", "gcO", "gcc", "gco", { "gb", mode = "x" }, { "gc", mode = "x" } },
  },

  {
    "unblevable/quick-scope",
    event = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },

  -- Text objects
  { "kana/vim-textobj-indent", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "kana/vim-textobj-line", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "rhysd/vim-textobj-anyblock", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "sgur/vim-textobj-parameter", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "wellle/targets.vim", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
}
