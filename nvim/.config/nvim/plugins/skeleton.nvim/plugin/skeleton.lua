local skeleton = require("skeleton")

vim.api.nvim_create_user_command("Skeleton", skeleton.open, { nargs = 0, desc = "Insert a skeleton" })
