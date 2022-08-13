Plug 'voldikss/vim-floaterm'

" Open terminal with double comma
nmap <leader><leader> :FloatermToggle<CR>

" Close terminal with escape key
tnoremap <silent> <Esc> <C-\><C-n>

let g:floaterm_height=0.8
let g:floaterm_width=0.9
