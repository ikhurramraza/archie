Plug 'phaazon/hop.nvim'

function HopSetup()
  lua require('hop').setup()
endfunction

augroup HopSetup
    autocmd!
    autocmd User PlugLoaded call HopSetup()
augroup END

nmap s :HopChar2<cr>
