--- Boolean flag that controls the auto formatting on save
--- @type boolean
local auto_format = false

--- Cache for bundle_command function
--- @type string | nil
local bundle_command_prefix_cache = nil

--- Helper method that converts a command to a bundler command
--- based on the the presence of "vendor/bundle" directory in
--- the project root directory.
--- @param command string
--- @return string
local function bundle_command(command)
  if bundle_command_prefix_cache then
    return bundle_command_prefix_cache .. command
  end

  local Path = require("plenary.path")
  local vendor_bundle_path = Path:new(vim.fn.getcwd() .. "/vendor/bundle")

  if vendor_bundle_path:is_dir() then
    bundle_command_prefix_cache = "bundle exec "
  else
    bundle_command_prefix_cache = ""
  end

  return bundle_command(command)
end

--- Formatter definition for syntax tree
local stree = function()
  return {
    exe = bundle_command("stree"),
    args = { "format" },
    stdin = true,
  }
end

--- Formmater definition for rubocop
--- Disabled for performance reasons
--- @diagnostic disable-next-line: unused-function, unused-local
local rubocop = function()
  local util = require("formatter.util")

  return {
    exe = bundle_command("rubocop"),
    stdin = true,
    no_append = true,
    args = {
      "--format=quiet",
      "--autocorrect-all",
      "--stderr",
      "--stdin",
      util.escape_path(util.get_current_buffer_file_path()),
    },
  }
end

--- Formmater definition for sql-formatter
local sql_formatter = function()
  local config_path = vim.fn.stdpath("config") .. "/files/" .. "sql-formatter.json"

  return {
    exe = "sql-formatter",
    args = { "--config", config_path },
    stdin = true,
  }
end

return {
  "mhartington/formatter.nvim",
  main = "formatter",
  cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
  keys = {
    {
      "<leader>xf",
      vim.cmd.Format,
      desc = "Execute format",
    },
    {
      "<leader>of",
      function()
        auto_format = not auto_format
      end,
      silent = true,
      desc = "Toggle formatting on save",
    },
  },
  config = function(plugin, opts)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*",
      callback = function()
        if auto_format then
          vim.cmd.FormatWrite()
        end
      end,
    })

    require(plugin.main).setup(opts)
  end,
  opts = function()
    return {
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
        lua = { require("formatter.filetypes.lua").stylua },
        markdown = { require("formatter.filetypes.markdown").prettier },
        ruby = { stree },
        rust = { require("formatter.filetypes.rust").rustfmt },
        sql = { sql_formatter },
        toml = { require("formatter.filetypes.toml").taplo },

        javascript = { require("formatter.filetypes.javascript").prettier },
        javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
        typescript = { require("formatter.filetypes.typescript").prettier },
        typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },

        sh = { require("formatter.filetypes.sh").shfmt },
        zsh = { require("formatter.filetypes.sh").shfmt },
      },
    }
  end,
}
