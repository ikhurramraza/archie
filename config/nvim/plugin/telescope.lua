local present, telescope = pcall(require, "telescope")

if not present then
  return
end

local actions = require("telescope.actions")
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
  },

  extensions = {
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = { preview_height = 0.8 },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("undo")

vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>so", "<cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>ss", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<CR>")
