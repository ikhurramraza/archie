Plug 'lewis6991/gitsigns.nvim'

function GitSignsSetup()
    lua require("gitsigns").setup()
endfunction

augroup GitSignsSetup
    autocmd!
    autocmd User PlugLoaded call GitSignsSetup()
augroup END
