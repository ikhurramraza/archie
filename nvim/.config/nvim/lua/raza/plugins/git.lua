return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewFileHistory", "DiffviewOpen" },
    keys = {
      {
        "<leader>od",
        vim.cmd.DiffviewFileHistory,
        silent = true,
        desc = "Toggle git diff view",
      },
    },
    opts = { show_help_hints = false },
  },

  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      {
        "<leader>gg",
        vim.cmd.Neogit,
        silent = true,
        desc = "Open Neogit view",
      },
    },
    opts = { kind = "replace" },
  },

  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
    config = function()
      vim.g.gitblame_enabled = false
    end,
    keys = {
      {
        "<leader>ob",
        vim.cmd.GitBlameToggle,
        silent = true,
        desc = "Toggle git blame",
      },
    },
  },

  {
    "yutkat/git-rebase-auto-diff.nvim",
    ft = { "gitrebase" },
    config = true,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local set = vim.keymap.set

        set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Previous git change hunk" })
        set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next git change hunk" })
        set("n", "<leader>hb", gs.blame_line, { buffer = bufnr, desc = "Show git blame for current line" })
        set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview git change hunk" })
        set("n", "<leader>hP", gs.preview_hunk_inline, { buffer = bufnr, desc = "Preview git change hunk inline" })
        set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { buffer = bufnr, desc = "Reset git change hunk" })
        set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset git changes for the buffer" })
        set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Stage git change hunk" })
        set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage git changes for the buffer" })
      end,
    },
  },

  {
    "tyru/open-browser-github.vim",
    dependencies = "tyru/open-browser.vim",
    keys = {
      { "<leader>ghf", "<CMD>OpenGithubFile<CR>", silent = true, desc = "Open current file on Github" },
      { "<leader>ghp", "<CMD>OpenGithubPullReq<CR>", silent = true, desc = "Open current PR on Github" },
    },
  },
}
