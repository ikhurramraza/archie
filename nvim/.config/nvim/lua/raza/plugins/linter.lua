-- TODO: Refactor me. I am ugly.

return {
  {
    "mfussenegger/nvim-lint",
    ft = { "ruby" },
    opts = {

      events = {
        "BufReadPost",
        "BufWritePost",
      },

      linters_by_ft = {
        ruby = { "rubocop" },
      },

      -- Override or add new linters
      linters = {
        rubocop = {
          cmd = function()
            local bundled = require("raza.bundler").bundle_command("rubocop"):find("^bundle") ~= nil

            if bundled then
              return "bundle"
            else
              return "rubocop"
            end
          end,

          args = {
            function()
              local bundled = require("raza.bundler").bundle_command("rubocop"):find("^bundle") ~= nil

              if bundled then
                return "exec"
              else
                return ""
              end
            end,
            function()
              local bundled = require("raza.bundler").bundle_command("rubocop"):find("^bundle") ~= nil

              if bundled then
                return "rubocop"
              else
                return ""
              end
            end,
            "--format",
            "json",
            "--force-exclusion",
          },
        },
      },
    },

    config = function(_, opts)
      local lint = require("lint")

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        else
          lint.linters[name] = linter
        end
      end

      lint.linters_by_ft = opts.linters_by_ft

      function debounce(ms, fn)
        local timer = vim.loop.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },
}
