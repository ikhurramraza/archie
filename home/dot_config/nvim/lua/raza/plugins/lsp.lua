return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        config = true,
      },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = { ensure_installed = { "vtsls", "lua_ls" } },
      },
      "hrsh7th/cmp-nvim-lsp",
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            display = {
              format_annote = function()
                return ""
              end,
              format_message = function()
                return ""
              end,
            },
          },
        },
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Extend capabilities for all servers so nvim-cmp gets LSP completions
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- vtsls: TypeScript/JavaScript (VSCode TS extension wrapped as LSP)
      -- Preferred over ts_ls — better performance and feature parity with VSCode
      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              returnTypes = { enabled = true },
            },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              returnTypes = { enabled = true },
            },
          },
        },
      })

      -- lua_ls: Lua (lazydev.nvim handles vim.* globals and library paths)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      -- Buffer-local keymaps not covered by Neovim's built-in gr* defaults
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end
          local opts = { buffer = ev.buf }

          if client:supports_method("textDocument/definition") then
            vim.keymap.set(
              "n",
              "gd",
              vim.lsp.buf.definition,
              vim.tbl_extend("force", opts, { desc = "Go to definition" })
            )
          end

          if client:supports_method("textDocument/declaration") then
            vim.keymap.set(
              "n",
              "gD",
              vim.lsp.buf.declaration,
              vim.tbl_extend("force", opts, { desc = "Go to declaration" })
            )
          end

          vim.keymap.set(
            "n",
            "<leader>xF",
            vim.lsp.buf.format,
            vim.tbl_extend("force", opts, { desc = "Format using LSP" })
          )

          if client:supports_method("textDocument/inlayHint") then
            vim.keymap.set("n", "<leader>ih", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
            end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
          end
        end,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
    },
    config = function()
      -- Default directory formatter uses only :~ (home-relative) for top-level groups.
      -- Patch to add :. so paths under cwd show as cwd-relative instead.
      local fmt = require("trouble.format")
      fmt.formatters.directory = function(ctx)
        if ctx.node:source() == "fs" then
          local directory = ctx.item.directory or ""
          local parent = ctx.node:parent_item()
          if parent and parent.directory then
            directory = directory:sub(#parent.directory + 1)
          else
            directory = vim.fn.fnamemodify(directory, ":~:.")
          end
          return { text = directory, hl = "TroubleDirectory" }
        end
      end
      require("trouble").setup()
    end,
  },
}
