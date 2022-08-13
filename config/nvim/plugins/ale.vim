Plug 'dense-analysis/ale'

let g:ale_fix_on_save = 0
let g:ale_ruby_rubocop_executable = 'bundle'

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'ruby': ['prettier', 'rubocop'],
\}

let g:ale_linters_ignore = {
\  'ruby': ['reek', 'sorbet', 'brakeman'],
\}

nmap gd :ALEGoToDefinition<CR>
nmap K  :ALEHover<CR>

nmap <leader>f :ALEFix<cr>

command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
