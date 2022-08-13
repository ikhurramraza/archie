Plug 'vim-test/vim-test'

nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ta :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

nnoremap <silent> <leader>tN :TestNearest -strategy=neovim<CR>
nnoremap <silent> <leader>tF :TestFile -strategy=neovim<CR>
nnoremap <silent> <leader>tA :TestSuite -strategy=neovim<CR>
nnoremap <silent> <leader>tL :TestLast -strategy=neovim<CR>
nnoremap <silent> <leader>tV :TestVisit -strategy=neovim<CR>

let test#strategy = 'basic'
let test#basic#start_normal = 1
let test#neovim#start_normal = 1
let test#neovim#term_position = 'vert botright 50'
