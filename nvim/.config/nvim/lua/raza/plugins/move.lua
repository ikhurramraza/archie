return {
  "fedepujol/move.nvim",
  keys = {
    { "<C-j>", ":MoveLine(1)<CR>", silent = true, desc = "Move line to one line down" },
    { "<C-k>", ":MoveLine(-1)<CR>", silent = true, desc = "Move line to one line down" },
    { "<C-j>", ":MoveBlock(1)<CR>", mode = "v", silent = true, desc = "Move block to one line down" },
    { "<C-k>", ":MoveBlock(-1)<CR>", mode = "v", silent = true, desc = "Move block to one line down" },
  },
  opts = {
    block = { enable = true, indent = true },
    char = { enable = false },
    line = { enable = true, indent = true },
    word = { enable = false },
  },
}
