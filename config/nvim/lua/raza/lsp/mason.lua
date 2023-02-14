local mason = require("mason")
local config = require("mason-lspconfig")

mason.setup()

config.setup({
  ensure_installed = { "lua_ls" },
})
