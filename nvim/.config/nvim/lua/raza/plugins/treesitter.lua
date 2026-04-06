return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    lazy = false,
    build = ":TSUpdate",
    opts = { endwise = { enable = true } },
    init = function()
      -- Enable highlighting and indentation
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      -- Install parsers
      local parsersToInstall = {
        "bash",
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
      }

      local alreadyInstalled = require("nvim-treesitter.config").get_installed()
      local parsersToInstall = vim
        .iter(parsersToInstall)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
      require("nvim-treesitter").install(parsersToInstall)
    end,
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
