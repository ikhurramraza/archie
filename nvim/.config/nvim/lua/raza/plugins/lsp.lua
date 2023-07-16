local Mason = {
  "williamboman/mason-lspconfig.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      "lua_ls",
      "eslint",
      "rust_analyzer",
      "tsserver",
    },
  },
  dependencies = { "williamboman/mason.nvim", config = true },
}

local Fidget = {
  "j-hui/fidget.nvim",
  opts = {
    timer = {
      task_decay = 100,
      fidget_decay = 100,
    },
  },
}

local M = {
  "neovim/nvim-lspconfig",
  cmd = { "LspInfo", "LspStart" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    Fidget,
    Mason,
  },
  keys = {
    {
      "<leader>ol",
      function()
        if next(vim.lsp.get_active_clients()) == nil then
          vim.cmd.LspStart()
          print("LSP server started")
        else
          vim.cmd.LspStop()
          print("LSP server stopped")
        end
      end,
      silent = true,
      desc = "Toggle LSP server",
    },
  },
}

function M.config()
  local lsp = require("lspconfig")
  local config = require("raza.lsp")

  local lua = lsp.lua_ls
  local ruby = lsp.solargraph

  lua.setup({
    autostart = false,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        completion = { keywordSnippet = "Disable" },
      },
    },
  })

  ruby.setup({
    autostart = false,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    init_options = { formating = false },
  })
end

local Rust = {
  "simrat39/rust-tools.nvim",
  main = "rust-tools",
  ft = "rust",
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    local config = require("raza.lsp")

    require("rust-tools").setup({
      server = {
        autostart = false,
        on_attach = config.on_attach,
        capabilities = config.capabilities,
      },
    })
  end,
}

local Typescript = {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "javascript", "javascript.jsx", "javascriptreact", "typescript", "typescript.tsx", "typescriptreact" },
  dependencies = "neovim/nvim-lspconfig",
  config = function()
    local config = require("raza.lsp")

    require("typescript").setup({
      server = {
        autostart = false,
        on_attach = config.on_attach,
        capabilities = config.capabilities,
      },
    })
  end,
}

return { M, Rust, Typescript }
