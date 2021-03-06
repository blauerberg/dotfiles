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

"
" for php
"
if has("autocmd")
  autocmd FileType php let php_sql_query=1
  autocmd FileType php let php_htmlInStrings=1
endif

"
" for drupal
"
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
    autocmd BufRead,BufNewFile *.theme set filetype=php
  augroup END
endif

"
" ctags
"
set tags=./tags;,tags;

"
" dein
"
if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein')
  call dein#add('morhetz/gruvbox')
  if has("python3")
    call dein#add('Shougo/deoplete.nvim')
  endif
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('b4b4r07/vim-buftabs')
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('ConradIrwin/vim-bracketed-paste')
  call dein#add('tpope/vim-surround')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimproc.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/neomru.vim')
  call dein#add('tsukkee/unite-tag')
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('scrooloose/syntastic')

  " php support
  call dein#add('shawncplus/phpcomplete.vim')
  if has('python3')
    call dein#add('joonty/vdebug')
  endif
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()

  if dein#check_install()
    call dein#install()
  endif
endif

filetype plugin indent on
syntax enable

"
" colorscheme
"
colorscheme gruvbox
set background=dark
set t_Co=256
let g:ligthline = { 'colorscheme': 'gruvbox' }

"
" solarized
"
let g:solarized_termcolors=256

"
" sudo.vim
"
nnoremap <Leader>ww :w sudo:%

"
" indent-guides
"
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=31
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
hi IndentGuidesOdd ctermbg=white
hi IndentGuidesEven ctermbg=darkgrey

"
" NERDTree
"
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw = 0

"
" tagbar
"
nnoremap <silent> <Leader>t :TagbarToggle<CR>

"
" vim-easy-align
"
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"
" ctrlp
"
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_root_markers = ['install.php']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }

"
" unite-outline
"
nnoremap <Leader>uo :Unite -auto-preview -winheight=9 outline<CR>
nnoremap <expr> <Leader>ug ':Unite -auto-preview -winheight=9 grep:.<CR>' . expand('<cword>')
nnoremap <expr> <Leader>dg ':Denite -auto-preview -winheight=9 grep:.<CR>' . expand('<cword>')

"
" unite buffer
"
nnoremap <Leader>ub :Unite buffer<CR>

"
" vim-gitgutter
" @see https://github.com/airblade/vim-gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"
" deoplate
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
