Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

scriptencoding 'utf-8'

function LuaLineSetup()
lua << END
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{'branch', icon=''}, 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
END
endfunction

augroup LuaLineSetup
    autocmd!
    autocmd User PlugLoaded call LuaLineSetup()
augroup END
