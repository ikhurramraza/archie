function TmuxStrategy(command)
  vim.fn.execute("silent !tmux send-keys -t shell '" .. command .. "' Enter")
  vim.fn.execute("silent !tmux select-window -t shell")
end

return {
  "vim-test/vim-test",
  config = function()
    vim.g["test#strategy"] = "tmux"
    vim.g["test#custom_strategies"] = { tmux = TmuxStrategy }
  end,
  keys = {
    { "<leader>tn", "<CMD>TestNearest<CR>", silent = true, desc = "Test nearest using default strategy" },
    { "<leader>tf", "<CMD>TestFile<CR>", silent = true, desc = "Test file using default strategy" },
    { "<leader>ta", "<CMD>TestSuite<CR>", silent = true, desc = "Test all using default strategy" },
    { "<leader>tl", "<CMD>TestLast<CR>", silent = true, desc = "Test last using default strategy" },
    { "<leader>tv", "<CMD>TestVisit<CR>", silent = true, desc = "Test visit using default strategy" },
  },
}
