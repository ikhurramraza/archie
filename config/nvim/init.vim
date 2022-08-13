" ---------------------------------------------------------------------------- "
"                               General settings                               "
" ---------------------------------------------------------------------------- "

scriptencoding 'utf-8'

set number
set relativenumber
set termguicolors

set expandtab
set scrolloff=10
set signcolumn=yes
set cursorline
set lazyredraw

autocmd TermOpen * setlocal nonumber norelativenumber

nnoremap <space> <nop>
let mapleader=' '

call plug#begin()

source ~/.config/nvim/plugins/ack.vim
source ~/.config/nvim/plugins/ale.vim
source ~/.config/nvim/plugins/auto_save.vim
source ~/.config/nvim/plugins/autonoh.vim
source ~/.config/nvim/plugins/buftabline.vim
source ~/.config/nvim/plugins/clap.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/dracula.vim
source ~/.config/nvim/plugins/float_term.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/gitsigns.vim
source ~/.config/nvim/plugins/hardtime.vim
source ~/.config/nvim/plugins/hop.vim
source ~/.config/nvim/plugins/lualine.vim
source ~/.config/nvim/plugins/multiple_cursors.vim
source ~/.config/nvim/plugins/open_in_github.vim
source ~/.config/nvim/plugins/prettier.vim
source ~/.config/nvim/plugins/projectionist.vim
source ~/.config/nvim/plugins/quickscope.vim
source ~/.config/nvim/plugins/repeat.vim
source ~/.config/nvim/plugins/rubocop.vim
source ~/.config/nvim/plugins/sort_motion.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/system_copy.vim
source ~/.config/nvim/plugins/test.vim
source ~/.config/nvim/plugins/textobj.vim
source ~/.config/nvim/plugins/which_key.vim

call plug#end()

doautocmd User PlugLoaded

" ---------------------------------------------------------------------------- "
"                                   Key maps                                   "
" ---------------------------------------------------------------------------- "

nmap <leader>ve :edit   ~/.config/nvim/init.vim<cr>
nmap <leader>vs :source ~/.config/nvim/init.vim<cr>

nmap <leader>Q :bufdo bdelete<cr>

nmap <leader>gf :edit <cfile><cr>
nmap <C-S> :w<cr>

" Buffer switching
nmap <Tab>   :bn<cr>
nmap <S-Tab> :bp<cr>
nmap <S-W>   :bw<cr>

" Moving lines up and down
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" This needs to be here otherwise it gets overriden
nmap gd :ALEGoToDefinition<cr>
nmap gr :ALEFindReferences<cr>

" Disables auto-commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
