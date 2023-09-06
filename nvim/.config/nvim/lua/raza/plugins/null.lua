local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = "neovim/nvim-lspconfig",
  cmd = { "NullLsInfo", "NullLsLog" },
  keys = {
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      silent = true,
      desc = "Open code actions menu",
    },
  },
}

function M.config()
  local null_ls = require("null-ls")
  local customs = require("raza.formatting")
  local config_path = vim.env.XDG_CONFIG_HOME .. "/null/"

  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.trail_space.with({
        disabled_filetypes = { "gitcommit" },
      }),
      null_ls.builtins.diagnostics.zsh,

      customs.code_actions.node_moduled_eslint,
      customs.diagnostics.bundled_rubocop,
      customs.diagnostics.node_moduled_eslint,
    },
  })
end

return M
