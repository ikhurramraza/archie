-- Save and exit keys
vim.keymap.set("n", "<C-S>", ":w<CR>", { silent = true })
vim.keymap.set("n", "<C-Q>", ":Bwipeout<CR>", { silent = true })

-- Switch and close buffers
vim.keymap.set("n", "<leader><Tab>", ":bn<CR>", { silent = true })
vim.keymap.set("n", "<leader><S-Tab>", ":bp<CR>", { silent = true })

-- Moving lines
vim.keymap.set("n", "<C-J>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<C-K>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("i", "<C-J>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-K>", "<Esc>:m .-2<CR>==gi", { silent = true })
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv", { silent = true })

-- Center after moving up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Copy file paths
vim.keymap.set("n", "<leader>cf", ":let @+=@%<CR>", { silent = true })
vim.keymap.set("n", "<leader>cl", ":let @+=@% . ':' . line('.')<CR>", { silent = true })

-- Replace current word
vim.keymap.set("n", "<leader>rw", ":%s/<C-r><C-w>")

-- Diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { silent = true })

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

-- Move to start/end of line in insert mode
vim.keymap.set("i", "<C-A>", "<C-O>_")
vim.keymap.set("i", "<C-E>", "<C-O>$")

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')

-- Delete without updating the registers
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Exit terminal mode with double escape
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")
