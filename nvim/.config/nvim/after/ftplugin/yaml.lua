-- Relates to: cuducos/yaml.nvim plugin
vim.keymap.set(
  "n",
  "<leader>yk",
  "<cmd>YAMLYankKey +<cr>",
  { buffer = 0, silent = true, desc = "Copy yaml key to system clipboard" }
)

vim.keymap.set(
  "n",
  "<leader>yv",
  "<cmd>YAMLYankValue +<cr>",
  { buffer = 0, silent = true, desc = "Copy yaml value to system clipboard" }
)

vim.keymap.set(
  "n",
  "<leader>yy",
  "<cmd>YAMLYank +<cr>",
  { buffer = 0, silent = true, desc = "Copy yaml key-value to system clipboard" }
)
