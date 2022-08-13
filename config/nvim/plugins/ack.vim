Plug 'mileszs/ack.vim'

let g:ackprg = 'ag --vimgrep --ignore=log --follow'

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
