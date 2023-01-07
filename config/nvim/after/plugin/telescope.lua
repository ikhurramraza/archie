local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")
local builtins = require("telescope.builtin")
local layout_actions = require("telescope.actions.layout")

local extensions = telescope.extensions
local undo_actions = require("telescope-undo.actions")
local grep_actions = require("telescope-live-grep-args.actions")

telescope.setup({
  defaults = {
    path_display = { truncate = 3 },
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-h>"] = layout_actions.toggle_preview,
      },
      n = {
        ["<C-c>"] = actions.close,
        ["<C-h>"] = layout_actions.toggle_preview,
      },
    },
  },

  pickers = {
    buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = { height = 0.25 },
    },

    find_files = {
      previewer = false,
      find_command = {
        "fd",
        "--hidden",
        "--type=f",
        "--exclude=.git/",
        "--exclude=node_modules/",
        "--exclude=vendor/bundle/",
      },
      layout_config = { preview_width = 0.6 },
    },

    current_buffer_fuzzy_find = {
      previewer = false,
      theme = "dropdown",
      winblend = 10,
    },

    lsp_references = {
      side_by_side = true,
      layout_strategy = "vertical",
      winblend = 3,
      layout_config = { preview_height = 0.75 },
    },
  },

  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = { preview_height = 0.65 },
      mappings = {
        i = {
          ["<CR>"] = undo_actions.restore,
          ["<leader>ya"] = undo_actions.yank_additions,
          ["<leader>yd"] = undo_actions.yank_deletions,
        },
      },
    },

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

    frecency = {
      default_workspace = "CWD",
      show_filter_column = false,
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("undo")
telescope.load_extension("frecency")
telescope.load_extension("live_grep_args")

vim.keymap.set("n", "<leader>sb", builtins.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sd", builtins.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sf", builtins.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", extensions.live_grep_args.live_grep_args, { desc = "[S]each by [G]rep" })
vim.keymap.set("n", "<leader>so", extensions.frecency.frecency, { desc = "[S]earch [O]ldfiles" })
vim.keymap.set("n", "<leader>sr", builtins.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>su", extensions.undo.undo, { desc = "[S]each [U]ndotree" })
vim.keymap.set("n", "<leader>sw", builtins.grep_string, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>gr", builtins.lsp_references, { desc = "[G]oto [R]eferences" })
vim.keymap.set("n", "<leader>/", builtins.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
