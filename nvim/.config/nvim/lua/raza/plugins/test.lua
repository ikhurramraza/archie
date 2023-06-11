return {
  "vim-test/vim-test",
  config = function()
    vim.g["test#strategy"] = "basic"
  end,
  keys = {
    { "<leader>tn", "<CMD>TestNearest<CR>", silent = true, desc = "Test nearest using basic strategy" },
    { "<leader>tf", "<CMD>TestFile<CR>", silent = true, desc = "Test file using basic strategy" },
    { "<leader>ta", "<CMD>TestSuite<CR>", silent = true, desc = "Test all using basic strategy" },
    { "<leader>tl", "<CMD>TestLast<CR>", silent = true, desc = "Test last using basic strategy" },
    { "<leader>tv", "<CMD>TestVisit<CR>", silent = true, desc = "Test visit using basic strategy" },

    { "<leader>tN", "<CMD>TestNearest -strategy=neovim<CR>", desc = "Test nearest using neovim strategy" },
    { "<leader>tF", "<CMD>TestFile    -strategy=neovim<CR>", desc = "Test file using neovim strategy" },
    { "<leader>tA", "<CMD>TestSuite   -strategy=neovim<CR>", desc = "Test all using neovim strategy" },
    { "<leader>tL", "<CMD>TestLast    -strategy=neovim<CR>", desc = "Test last using neovim strategy" },
    { "<leader>tV", "<CMD>TestVisit   -strategy=neovim<CR>", desc = "Test visit using neovim strategy" },
  },
}
