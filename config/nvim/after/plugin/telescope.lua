local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")
local builtins = require("telescope.builtin")
local extensions = telescope.extensions
local layout_actions = require("telescope.actions.layout")

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
      layout_config = {
        height = 0.25,
      },
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
      layout_config = {
        preview_width = 0.6,
      },
    },

    oldfiles = {
      previewer = false,
      cwd_only = true,
      layout_config = {
        preview_width = 0.6,
      },
    },

    live_grep = {
      previewer = false,
      theme = "dropdown",
      layout_config = {
        width = 0.9,
        height = 0.6,
      },
    },

    current_buffer_fuzzy_find = {
      previewer = false,
      theme = "dropdown",
      winblend = 10,
    },
  },

  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = { preview_height = 0.8 },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("undo")

vim.keymap.set("n", "<leader>sb", builtins.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sd", builtins.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sf", builtins.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtins.live_grep, { desc = "[S]each by [G]rep" })
vim.keymap.set("n", "<leader>so", builtins.oldfiles, { desc = "[S]earch [O]ldfiles" })
vim.keymap.set("n", "<leader>sr", builtins.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>su", extensions.undo.undo, { desc = "[S]each [U]ndotree" })
vim.keymap.set("n", "<leader>sw", builtins.grep_string, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>/", builtins.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
