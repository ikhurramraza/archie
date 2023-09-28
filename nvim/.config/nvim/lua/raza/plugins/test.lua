local function sanitize_command(command)
  local sanitized_command = command

  -- Replace "./bin/rails test" with "rails t"
  sanitized_command = string.gsub(command, "^./bin/rails test", "rails t")

  return sanitized_command
end

local function TmuxStrategy(command)
  local sanitized_command = sanitize_command(command)
  vim.fn.execute("silent !tmux send-keys -t shell C-l")
  vim.fn.execute("silent !tmux send-keys -t shell '" .. sanitized_command .. "' Enter")
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
