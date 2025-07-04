local Mason = {
  "williamboman/mason-lspconfig.nvim",
  cmd = "Mason",
  opts = {
    ensure_installed = {
      "lua_ls",
      "ruby_lsp",
      "rust_analyzer",
      "taplo",
      "ts_ls",
    },
  },
  dependencies = { "williamboman/mason.nvim", config = true },
}

local Fidget = {
  "j-hui/fidget.nvim",
  config = true,
}

local M = {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    Fidget,
    Mason,
  },
  opts = { inlay_hints = { enabled = true } },
  keys = {
    {
      "<leader>ol",
      function()
        if next(vim.lsp.get_active_clients()) == nil then
          vim.cmd.LspStart()
        else
          vim.cmd.LspStop()
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
  local ruby = lsp.ruby_lsp
  local taplo = lsp.taplo

  lua.setup({
    autostart = false,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        completion = { keywordSnippet = "Disable" },
        hint = { enable = true },
      },
    },
  })

  ruby.setup({
    autostart = false,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/ruby-lsp" },
  })

  taplo.setup({
    autostart = false,
    on_attach = config.on_attach,
    capabilities = config.capabilities,
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
        settings = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
        },
      },
    })
  end,
}

return { M, Rust, Typescript }
