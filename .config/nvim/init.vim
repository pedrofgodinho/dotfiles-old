""" Plugins """
call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let mapleader = "ç"

""" CoC setup """
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

set updatetime=300

set shortmess+=c

" Always show signcolumn, to avoid shifting left and right when diagnostics appear/disappear
" set signcolumn=yes

" Tab to cycle options
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

""" Rainbow """
let g:rainbow_active = 1

""" Airline Config """
let g:airline_powerline_fonts = 1

""" General nvim config """
set cmdheight=2

set number
set linebreak
set textwidth=120
set showmatch
set visualbell

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4

set ruler

set undolevels=1000
set backspace=indent,eol,start

set mouse=a
