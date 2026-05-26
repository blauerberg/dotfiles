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
set showcmd
set wildmenu
set wildmode=list:longest,full
set history=128
set viminfo='1024,f1,<512
set pumheight=10
set hidden
set updatetime=500
set backupcopy=yes
set completeopt=menu,menuone,preview
set showfulltag

" find files across the tree: :find Foo<Tab>
set path+=**

"
" leader
"
let mapleader = "\<Space>"

"
" clear search highlight
"
nnoremap <silent><ESC><ESC> :nohlsearch<CR>

"
" quickfix navigation (Neovim 0.11 ships these by default; define for plain Vim)
"
if !has('nvim')
  nnoremap [q :cprevious<CR>
  nnoremap ]q :cnext<CR>
  nnoremap [Q :<C-u>cfirst<CR>
  nnoremap ]Q :<C-u>clast<CR>
endif

"
" grep -> quickfix (prefer ripgrep when available)
"
if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnI\ --exclude-dir=.git
  set grepformat=%f:%l:%m,%f:%l:%m,%f\ \ %l%m,%f
endif
augroup grepopen
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

"
" quickfix buffer tweaks
"
augroup quickfix
  autocmd!
  autocmd BufReadPost quickfix call s:initialize_quickfix()
augroup END
function! s:initialize_quickfix()
  nnoremap <buffer> q <C-w>c
  setlocal norelativenumber
endfunction

"
" restore last cursor position when reopening a file
"
augroup last_position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
augroup END

filetype plugin indent on
if has("syntax")
  syntax on
endif

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
