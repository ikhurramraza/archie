local GitBlame = {
  "f-person/git-blame.nvim",
  cmd = "GitBlameToggle",
  config = function()
    vim.g.gitblame_enabled = 0
  end,
  keys = {
    {
      "<leader>ob",
      vim.cmd.GitBlameToggle,
      silent = true,
      desc = "Toggle git blame",
    },
  },
}

local GitSigns = {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr })
      vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr })
      vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr })
    end,
  },
}

local GithubOpen = {
  "tyru/open-browser-github.vim",
  dependencies = "tyru/open-browser.vim",
  keys = {
    { "<leader>ghf", "<CMD>OpenGithubFile<CR>", silent = true, desc = "Open current file on Github" },
    { "<leader>ghp", "<CMD>OpenGithubPullReq<CR>", silent = true, desc = "Open current PR on Github" },
  },
}

return { GitBlame, GitSigns, GithubOpen }
