" ----- Plugins -----
call plug#begin('~/.config/nvim/plugged')

Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'bcicen/vim-vice'
Plug 'jiangmiao/auto-pairs'
Plug 'farmergreg/vim-lastplace'

call plug#end()

" --- CoC setup ---
set hidden
set cmdheight=2

" Some servers have issues with backup files. Uncomment this if you face such issues
"set nobackup
"set nowritebackup

set updatetime=300

set shortmess+=c

" If using diagnostic tools, might want to enable this to avoid text shifting left and right all the time
"set signcolumn=yes

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

" ----- Rainbow -----
let g:rainbow_active = 1

" ----- Airline Config -----
let g:airline_powerline_fonts = 1

" ----- General Vim Config -----
syntax on
colorscheme vice

" Spaces and Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

set autoindent
set smartindent

set backspace=indent,eol,start

" UI
set number relativenumber
set wildmenu
set mouse=a
set scrolloff=10

" Search
set showmatch
set incsearch
set hlsearch

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za

" Movement
nnoremap j gj
nnoremap k gk

" Clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
