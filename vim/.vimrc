"
" global
"
set nocompatible
set background=dark
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
nnoremap <Tab> <C-w><C-w>
nnoremap <silent><ESC><ESC> :noh<CR>

"
" status line
"
au InsertEnter * hi StatusLine
  \ guifg=DarkBlue
  \ guibg=DarkYellow
  \ gui=none
  \ ctermfg=Blue
  \ ctermbg=Yellow
  \ cterm=none

au InsertLeave * hi StatusLine
  \ guifg=DarkBlue
  \ guibg=White
  \ gui=none
  \ ctermfg=Blue
  \ ctermbg=White
  \ cterm=none
set statusline=%F%m%r%h%w\%=[%l,%v/%L]\[%{&ft}]\[%{&ff}]\[%{&fileencoding}]

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

augroup helpgrepopen
  autocmd!
  autocmd QuickFixCmdPost helpgrep cw
augroup END

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
  au BufReadPost uuickfix call s:initialize_quickfix()
augroup END

function! s:initialize_quickfix()
  nnoremap <buffer> q <C-w>c
  setl norelativenumber
endfunction


function! s:toggle_language(path)
  let lang = { '/en/': '/ja/', '/ja/': '/en/', '\.en\.': '\.ja\.', '\.ja\.': '\.en\.' }
  for [key, value] in items(lang)
    if strlen(matchstr(a:path, key)) != 0
      return substitute(a:path, key, value, '')
    endif
  endfor
  return a:path
endfunction

nnoremap <expr> <Leader>ug ':Unite grep:.<CR>' . expand('<cword>')
nnoremap <expr> <Leader>uG ':Unite grep:%<CR>' . expand('<cword>')
nnoremap <expr> <Leader>gr ':sil grep! ' . expand('<cword>') . ' *'
nnoremap <silent> <Leader>te :e <C-r>=<SID>toggle_language(expand("%"))<CR><CR>

"
" colorscheme
"
colorscheme atom-dark-256

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
  autocmd FileType php let php_folding=1
endif

"
" for drupal
"
if has("autocmd")
  augroup drupal
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.theme set filetype=php
  augroup END
endif

"
" neobundle
"
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"
" bundles (common)
"
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
NeoBundle 'https://github.com/majutsushi/tagbar.git'
NeoBundle 'https://github.com/ctrlpvim/ctrlp.vim.git'
NeoBundle 'https://github.com/b4b4r07/vim-buftabs.git'
NeoBundle 'https://github.com/vim-scripts/netrw.vim.git'
NeoBundle 'https://github.com/Shougo/vimfiler.git'
NeoBundle 'https://github.com/vim-scripts/sudo.vim.git'
"
" bundles (editor)
"
NeoBundle 'https://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
NeoBundle 'https://github.com/bronson/vim-trailing-whitespace.git'
NeoBundle 'https://github.com/kana/vim-smartchr.git'
NeoBundle 'https://github.com/junegunn/vim-easy-align.git'
NeoBundle 'https://github.com/godlygeek/tabular.git'
NeoBundle 'https://github.com/ConradIrwin/vim-bracketed-paste.git'
NeoBundle 'https://github.com/tpope/vim-surround.git'
"
" bundles (unite)
"
NeoBundle 'https://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/Shougo/unite-outline.git'
NeoBundle 'https://github.com/tsukkee/unite-tag.git'
"
" bundles (git)
"
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/airblade/vim-gitgutter.git'
NeoBundle 'https://github.com/tyru/open-browser.vim.git'
NeoBundle 'https://github.com/tyru/open-browser-github.vim.git'
NeoBundle 'https://github.com/rhysd/github-complete.vim.git'
"
" bundles (development)
"
NeoBundle 'https://github.com/scrooloose/syntastic.git'
NeoBundle 'https://github.com/joonty/vdebug.git'

"NeoBundle 'https://github.com/taku-o/vim-vis.git'
"NeoBundle 'https://github.com/thinca/vim-ref.git'
NeoBundle 'https://github.com/Shougo/vimproc.git'

"NeoBundle 'https://github.com/hsitz/VimOrganizer.git'
"NeoBundle 'https://github.com/thinca/vim-visualstar.git'
"NeoBundle 'https://github.com/jceb/vim-orgmode.git'
"NeoBundle 'https://github.com/tpope/vim-speeddating.git'
"NeoBundle 'https://github.com/kannokanno/previm.git'
"NeoBundle 'https://github.com/dhruvasagar/vim-table-mode.git'
"NeoBundle 'https://github.com/thinca/vim-quickrun.git'
"NeoBundle 'https://github.com/tpope/vim-rails.git'
"NeoBundle 'c.vim'
"NeoBundle 'YankRing.vim'
"NeoBundle 'https://github.com/houtsnip/vim-emacscommandline.git'
"NeoBundle 'matchit.zip'
"NeoBundle 'https://github.com/kana/vim-textobj-user.git'
"NeoBundle 'https://github.com/kana/vim-textobj-indent.git'
"NeoBundle 'https://github.com/kana/vim-textobj-lastpat.git'
"NeoBundle 'https://github.com/kana/vim-textobj-line.git'
"NeoBundle 'https://github.com/kana/vim-textobj-fold.git'
"NeoBundle 'https://github.com/kana/vim-textobj-entire.git'
"NeoBundle 'https://github.com/kana/vim-textobj-jabraces.git'
"NeoBundle 'https://github.com/kana/vim-textobj-datetime.git'
"NeoBundle 'https://github.com/kana/vim-textobj-syntax.git'
"NeoBundle 'https://github.com/kana/vim-textobj-between.git'
"NeoBundle 'https://github.com/kana/vim-textobj-comment.git'
"NeoBundle 'operator-camelize.vim'
"NeoBundle 'operator-sort.vim'
"NeoBundle 'operator-reverse.vim'
"NeoBundle 'ZenCoding.vim'
"NeoBundle 'https://github.com/tsukkee/unite-gtags.git'
"NeoBundle 'Align'
"NeoBundle 'https://github.com/itchyny/calendar.vim.git'
"NeoBundle 'https://github.com/chrisbra/NrrwRgn.git'
"NeoBundle 'https://github.com/vim-scripts/utl.vim.git'
"NeoBundle 'Markdown'
"NeoBundle 'https://github.com/tpope/vim-pathogen.git'
"NeoBundle 'https://github.com/majutsushi/tagbar.git'
"NeoBundle 'https://github.com/jistr/vim-nerdtree-tabs.git'
"NeoBundle 'https://github.com/krisajenkins/vim-pipe.git'

"NeoBundle 'jscomplete-vim'
"NeoBundle 'quickfixstatus'
"NeoBundle 'vim-hier'
"NeoBundle 'vim-textmanip'
"NeoBundle 'headlights'
"NeoBundle 'trinity.vim'
"NeoBundle 'gtags.vim'
"NeoBundle 'vim-javascript'
"NeoBundle 'csv.vim'

if has('lua') && ((v:version >= 703 && has('patch885')) || v:version >= 704)
  NeoBundleLazy "Shougo/neocomplete.vim", {
    \ "autoload": {
    \   "insert": 1,
    \ }}

  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  
  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }
  
  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'
  
  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()
  
  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return "\<C-y>\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " Close popup by <Space>.
  inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
  
  " AutoComplPop like behavior.
  let g:neocomplete#enable_auto_select = 1
  
  " Shell like behavior(not recommended).
  set completeopt+=longest
  let g:neocomplete#enable_auto_select = 1
  let g:neocomplete#disable_auto_complete = 1
  inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
  
  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  
  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  
  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

else
  NeoBundleLazy "Shougo/neocomplcache.vim", {
        \ "autoload": {
        \   "insert": 1,
        \ }}
  let g:neocomplcache_enable_startup = 1
  let s:hooks = neobundle#get_hooks("neocomplcache.vim")
  function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_min_syntax_length = 3
  endfunction
endif

call neobundle#end()
NeoBundleCheck

filetype plugin indent on

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
hi IndentGuidesOdd  ctermbg=white
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
" vimfiler
"
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <silent> <Leader>vf :VimFilerExplorer -parent<CR>

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
"let g:ctrlp_max_height = 10
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ }

"
" unite-outline
"
nnoremap <Leader>uo :Unite -auto-preview -winheight=8 outline<CR>

"
" vim-gitgutter
" @see https://github.com/airblade/vim-gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_eager = 1

"
" vim-ref
"
let g:ref_phpmanual_path = $HOME . '/.vim/ref/phpmanual/'
let g:ref_phpmanual_cmd = 'elinks -dump -no-numbering -no-references %s'
autocmd FileType ref call s:initialize_ref_viewer()
function! s:initialize_ref_viewer()
  nmap <buffer> b <Plug>(ref-back)
  nmap <buffer> f <Plug>(ref-forward)
  nnoremap <buffer> q <C-w>c
  setlocal nonumber
  ".... and more settings ...
endfunction

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
