local present, _ = pcall(require, "harpoon")

if not present then
  return
end

local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

local function navigate_to(num)
  return function()
    ui.nav_file(num)
  end
end

vim.keymap.set("n", ",a", mark.add_file)
vim.keymap.set("n", ",h", ui.toggle_quick_menu)

vim.keymap.set("n", ",1", navigate_to(1))
vim.keymap.set("n", ",2", navigate_to(2))
vim.keymap.set("n", ",3", navigate_to(3))
vim.keymap.set("n", ",4", navigate_to(4))

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
