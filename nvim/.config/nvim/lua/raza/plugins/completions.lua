local M = {
  "hrsh7th/nvim-cmp",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    { dir = vim.fn.stdpath("config") .. "/plugins/cmp-git-authors" },
  },
}

function M.config()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  local loaders = {
    lua = require("luasnip.loaders.from_lua"),
    vscode = require("luasnip.loaders.from_vscode"),
  }

  loaders.vscode.lazy_load({
    paths = { vim.fn.stdpath("config") .. "/sneaps" },
    exclude = { "gitcommit" },
  })

  loaders.lua.load({
    paths = vim.fn.stdpath("config") .. "/lua/raza/snippets",
  })

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),

      -- LuaSnip tab completion mappings
      ["<Tab>"] = cmp.mapping(function(fallback)
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path", keyword_length = 3 },
      { name = "buffer", keyword_length = 3 },
    }),
  })

  cmp.setup.filetype("gitcommit", { sources = { { name = "git-authors" } } })
end

return M
