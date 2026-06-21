" --- Indentation ---
set expandtab          " use spaces instead of tabs
set tabstop=4          " tab width
set shiftwidth=4       " indent width
set softtabstop=4      " backspace deletes 4 spaces at once

" --- Line numbers ---
set number             " show absolute line number on current line
set relativenumber     " relative numbers on all other lines

" --- Search ---
set ignorecase         " case-insensitive search...
set smartcase          " ...unless you type a capital
set incsearch          " highlight as you type
set hlsearch           " highlight all matches

" --- Usability ---
set scrolloff=8        " keep 8 lines visible above/below cursor
set sidescrolloff=8
set nowrap             " don't wrap long lines
set hidden             " allow switching buffers without saving
set backspace=indent,eol,start  " sane backspace in insert mode
set clipboard=unnamed  " yank/paste with system clipboard

" --- Appearance ---
set cursorline         " highlight the current line
set colorcolumn=100    " vertical ruler at 100 chars
set signcolumn=no     " always show the gutter (avoids layout shifts)
set laststatus=2       " always show status bar
set showmatch          " briefly jump to matching bracket

" --- Performance / behavior ---
set noswapfile         " no .swp files
set nobackup
set undofile           " persistent undo across sessions
set undodir=~/.vim/undodir

" --- Leader key ---
let mapleader = " "

" --- Handy remaps ---
nnoremap <leader>h :nohlsearch<CR>   " clear search highlights
nnoremap <C-d> <C-d>zz               " keep cursor centered on half-page jumps
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv                      " keep cursor centered when cycling matches
nnoremap N Nzzzv

