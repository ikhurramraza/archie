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
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    dir = vim.fn.stdpath("config") .. "/plugins/skeleton",
    config = true,
    cmd = "Skeleton",
    keys = { { "<leader>gs", vim.cmd.Skeleton, desc = "Insert a skeletons" } },
  },

  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = { TelescopePrompt = false }
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
      {
        "<C-l>",
        "<Plug>(copilot-suggest)",
        mode = "i",
        silent = true,
        desc = "Suggest a completion using Copilot",
      },
    },
  },

  {
    "numToStr/Comment.nvim",
    config = true,
    keys = {
      "gbc",
      "gc",
      "gcA",
      "gcO",
      "gcc",
      "gco",
      { "gb", mode = "x" },
      { "gc", mode = "x" },
    },
  },

  {
    "LudoPinelli/comment-box.nvim",
    opts = { box_width = 75, line_width = 75 },
    cmd = {
      "CBccbox",
      "CBccline",
      "CBclbox",
      "CBclline",
      "CBcrbox",
      "CBcrline",
      "CBlcbox",
      "CBlcline",
      "CBllbox",
      "CBllline",
      "CBlrbox",
      "CBlrline",
      "CBrcbox",
      "CBrcline",
      "CBrlbox",
      "CBrlline",
      "CBrrbox",
      "CBrrline",
    },
  },

  {
    "unblevable/quick-scope",
    event = "VeryLazy",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },

  {
    "stevearc/oil.nvim",
    opts = {
      columns = {},
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },
    dependencies = "kyazdani42/nvim-web-devicons",
    keys = { { "-", vim.cmd.Oil, desc = "Open parent directory using Oil" } },
  },

  {
    "otavioschwanck/arrow.nvim",
    config = function(plugin, opts)
      require("arrow").setup(opts)

      vim.keymap.set("n", "H", require("arrow.persist").previous)
      vim.keymap.set("n", "L", require("arrow.persist").next)
    end,
    opts = {
      always_show_path = true,
      hide_handbook = true,
      leader_key = ";",
      separate_by_branch = true,
      show_icons = true,
    },
  },

  -- Text objects
  { "kana/vim-textobj-indent", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "kana/vim-textobj-line", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "rhysd/vim-textobj-anyblock", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "sgur/vim-textobj-parameter", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
  { "wellle/targets.vim", dependencies = "kana/vim-textobj-user", event = "VeryLazy" },
}
