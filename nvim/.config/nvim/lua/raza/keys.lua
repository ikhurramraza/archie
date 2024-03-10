-- Switch buffers
vim.keymap.set("n", "]b", ":bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "[b", ":bp<CR>", { silent = true, desc = "Previous buffer" })

-- Center after moving up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy file paths
vim.keymap.set("n", "<leader>cf", ":let @+=expand('%:~:.')<CR>", { silent = true, desc = "Copy current file path" })
vim.keymap.set(
  "n",
  "<leader>cl",
  ":let @+=expand('%:~:.') . ':' . line('.')<CR>",
  { silent = true, desc = "Copy current file path with line number" }
)

-- Replace current word
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>", { desc = "Replace current word" })

-- LSP mappings (common between None and LSP)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Open code actions menu" })
vim.keymap.set("n", "<leader>xf", vim.lsp.buf.format, { silent = true, desc = "Execute format" })

-- Diagnostics
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Previous diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true, desc = "Open diagnostics window" })

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y', { silent = true, desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "Yank to system clipboard" })

-- Move to start/end of line in insert mode
vim.keymap.set("i", "<C-A>", "<C-O>_")
vim.keymap.set("i", "<C-E>", "<C-O>$")

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p', { silent = true, desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { silent = true, desc = "Paste from system clipboard" })

-- Delete without updating the registers
vim.keymap.set("n", "<leader>d", '"_d', { silent = true, desc = "Delete without registers" })
vim.keymap.set("v", "<leader>d", '"_d', { silent = true, desc = "Delete without registers" })

-- Exit terminal mode with double escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
