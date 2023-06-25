local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>sb", "<CMD>Telescope buffers<CR>", silent = true, desc = "[S]earch [B]uffers" },
    { "<leader>sd", "<CMD>Telescope diagnostics<CR>", silent = true, desc = "[S]earch [D]iagnostics" },
    { "<leader>sf", "<CMD>Telescope git_files<CR>", silent = true, desc = "[S]earch git [F]iles" },
    { "<leader>sF", "<CMD>Telescope find_files<CR>", silent = true, desc = "[S]earch [F]iles" },
    { "<leader>sg", "<CMD>Telescope live_grep_args<CR>", silent = true, desc = "[S]each by [G]rep" },
    { "<leader>sq", "<CMD>Telescope quickfix<CR>", silent = true, desc = "[S]earch [Q]uickfix" },
    { "<leader>sr", "<CMD>Telescope resume<CR>", silent = true, desc = "[S]earch [R]esume" },
    {
      "<leader>sw",
      "<CMD>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
      silent = true,
      desc = "[S]earch current [W]ord",
    },

    { "<leader>gr", "<CMD>Telescope lsp_references<CR>", silent = true, desc = "[G]oto [R]eferences" },
    { "<leader>/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "[/] Fuzzily search in current buffer" },
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
        },
        n = {
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
          "--exclude=.git/",
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
