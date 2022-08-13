Plug 'dracula/vim', { 'as': 'dracula' }

let g:dracula_italic = 0
let g:dracula_inverse = 0

augroup DraculaOverrides
    autocmd!
    autocmd ColorScheme dracula highlight DraculaBoundary guibg=none
    autocmd ColorScheme dracula highlight DraculaDiffDelete ctermbg=none guibg=none
    autocmd ColorScheme dracula highlight DraculaComment cterm=italic gui=italic
    autocmd ColorScheme dracula highlight DraculaTodo guifg=#6272A4
    autocmd User PlugLoaded ++nested colorscheme dracula
augroup end
