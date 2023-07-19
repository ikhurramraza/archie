local M = {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      ",h",
      "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>",
      silent = true,
      desc = "Toggle Harpoon quick menu",
    },
    {
      ",a",
      "<CMD>lua require('harpoon.mark').add_file()<CR>",
      silent = true,
      desc = "Add current file to Harpoon list",
    },
    {
      ",1",
      "<CMD>lua require('harpoon.ui').nav_file(1)<CR>",
      silent = true,
      desc = "Jump to file 1 on Harpoon list",
    },
    {
      ",2",
      "<CMD>lua require('harpoon.ui').nav_file(2)<CR>",
      silent = true,
      desc = "Jump to file 2 on Harpoon list",
    },
    {
      ",3",
      "<CMD>lua require('harpoon.ui').nav_file(3)<CR>",
      silent = true,
      desc = "Jump to file 3 on Harpoon list",
    },
    {
      ",4",
      "<CMD>lua require('harpoon.ui').nav_file(4)<CR>",
      silent = true,
      desc = "Jump to file 4 on Harpoon list",
    },
    {
      ",5",
      "<CMD>lua require('harpoon.ui').nav_file(5)<CR>",
      silent = true,
      desc = "Jump to file 5 on Harpoon list",
    },
  },
}

function M.config(plugin)
  require(plugin.name).setup()

  vim.api.nvim_create_autocmd("BufFilePost", {
    pattern = "harpoon-menu",
    callback = function()
      vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "<C-c>",
        "<CMD>lua require('harpoon.ui').toggle_quick_menu()<CR>",
        { silent = true }
      )
    end,
  })
end

return M
