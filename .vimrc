"
" global
"
set nocompatible
set backspace=eol,indent,start
set whichwrap=b,s,[,],<,>,~
set mouse=
set ruler
set relativenumber
set number
set modeline
set autoindent
set ts=2
set sts=2
set sw=2
set et
set smarttab
set smartcase
set showmatch
set incsearch
set hlsearch
set wrapscan
set laststatus=2
set showmode
set showcmd
set wildmode=list:longest
set cmdheight=4
set history=128
set viminfo='1024,f1,<512
set pumheight=10
set hidden
set updatetime=500

"
" keymap
"
let mapleader = "\<Space>"
nnoremap <Leader>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Leader>s. :<C-u>source $MYVIMRC<Enter>
nnoremap <C-j> <C-^>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <Tab> <C-w><C-w>
nnoremap <silent><ESC><ESC> :noh<CR>

nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>

augroup auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorcolumn
  autocmd CursorHold,CursorHoldI * setlocal cursorline
  autocmd CursorHold,CursorHoldI * setlocal cursorcolumn
augroup END

filetype plugin indent on
if has("syntax")
  syntax on
endif

"
"  grep
"
set grepformat=%f:%l:%m,%f:%l:%m,%f\ \ %l%m,%f
set grepprg=grep\ -rnI\ --exclude-dir=.git
augroup grepopen
  autocmd!
  autocmd QuickFixCmdPost *grep* cw
augroup END

augroup quickfix
  au!
  au BufReadPost quickfix call s:initialize_quickfix()
augroup END

function! s:initialize_quickfix()
  nnoremap <buffer> q <C-w>c
  setl norelativenumber
endfunction
nnoremap <expr> <Leader>gr ':sil grep! ' . expand('<cword>') . ' *'

"
" auto forcus to lastest position
"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line ("$") | exe "normal! g'\"" | endif

"
" completion
"
set completeopt=menu,menuone,preview
set showfulltag

if has("syntax")
  syntax on
endif

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
