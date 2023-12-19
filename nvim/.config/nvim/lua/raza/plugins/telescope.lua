local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>fb", "<CMD>Telescope buffers<CR>", silent = true, desc = "[F]ind [B]uffers" },
    { "<leader>fc", "<CMD>Telescope git_bcommits<CR>", silent = true, desc = "[F]ind buffer [C]ommits" },
    { "<leader>fC", "<CMD>Telescope git_commits<CR>", silent = true, desc = "[F]ind [C]ommits" },
    { "<leader>fd", "<CMD>Telescope diagnostics<CR>", silent = true, desc = "[F]ind [D]iagnostics" },
    { "<leader>ff", "<CMD>Telescope find_files<CR>", silent = true, desc = "[F]ind git [F]iles" },
    { "<leader>fF", "<CMD>Telescope git_files<CR>", silent = true, desc = "[F]ind [F]iles" },
    { "<leader>fg", "<CMD>Telescope live_grep_args<CR>", silent = true, desc = "[F]ind by [G]rep" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>", silent = true, desc = "[F]ind [H]elp" },
    { "<leader>fq", "<CMD>Telescope quickfix<CR>", silent = true, desc = "[F]ind [Q]uickfix" },
    { "<leader>fr", "<CMD>Telescope resume<CR>", silent = true, desc = "[F]ind [R]esume" },
    { "<leader>fs", "<CMD>Telescope git_status<CR>", silent = true, desc = "[F]ind git [S]tatus" },
    {
      "<leader>fw",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor({ postfix = " -Fs " })
      end,
      silent = true,
      desc = "[F]ind current [W]ord",
    },

    { "<leader>gr", "<CMD>Telescope lsp_references<CR>", silent = true, desc = "[G]oto [R]eferences" },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local layout_actions = require("telescope.actions.layout")
  local grep_actions = require("telescope-live-grep-args.actions")

  telescope.setup({
    defaults = {
      path_display = { truncate = 3 },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-h>"] = layout_actions.toggle_preview,
          ["<C-x>"] = actions.delete_buffer,
        },
        n = {
          ["dd"] = actions.delete_buffer,
          ["<C-c>"] = actions.close,
          ["<C-h>"] = layout_actions.toggle_preview,
        },
      },
    },

    pickers = {
      buffers = { previewer = false, preview_width = 0.6 },
      diagnostics = { previewer = false, preview_width = 0.6 },
      git_files = { previewer = false, preview_width = 0.6 },

      current_buffer_fuzzy_find = {
        previewer = false,
        preview_width = 0.6,
        theme = "dropdown",
        winblend = 10,
      },

      find_files = {
        previewer = false,
        preview_width = 0.6,
        find_command = {
          "fd",
          "--hidden",
          "--type=f",
          "--exclude=node_modules/",
          "--exclude=vendor/bundle/",
        },
      },

      lsp_references = {
        side_by_side = true,
        preview_width = 0.6,
        winblend = 3,
      },

      quickfix = {
        side_by_side = true,
        layout_strategy = "vertical",
        winblend = 3,
        layout_config = { preview_height = 0.65, preview_width = 0.6 },
      },
    },

    extensions = {
      live_grep_args = {
        previewer = false,
        auto_quoting = true,
        layout_config = { preview_width = 0.6, mirror = false },
        mappings = {
          i = {
            ["<C-k>"] = grep_actions.quote_prompt(),
            ["<C-i>"] = grep_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("live_grep_args")
end

return M
