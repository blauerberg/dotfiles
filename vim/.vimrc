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
set cursorline
set cursorcolumn
set colorcolumn=80
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
set clipboard+=unnamed

"
" common keymap
"
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>
nnoremap <C-j> <C-^>
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
set grepprg=grep\ -rI\ --exclude-dir=.git
augroup grepopen
  autocmd!
  "autocmd QuickFixCmdPost *grep* cw
augroup END

augroup quickfix
  au!
  au BufReadPost uuickfix call s:initialize_quickfix()
augroup END

function! s:initialize_quickfix()
  nnoremap <buffer> q <C-w>c
  setl norelativenumber
endfunction

"
" keymap
"
"nmap <silent> <C-n> :update<CR>:bn<CR>
"imap <silent> <C-n> :update<CR>:bn<CR>
"vmap <silent> <C-n> <ESC>:update<CR>:bn<CR>
"cmap <silent> <C-n> <ESC>:update<CR>:bn<CR>

"nnoremap <C-h> :<C-u>h<Space>
"nnoremap <C-h><C-h> :<C-u>h<Space><C-r><C-w><Enter>
"nnoremap gc `[v`]
"vnoremap gc :<C-u>normal gc<Enter>
"onoremap gc :<C-u>normal gc<Enter>

"nnoremap <expr> <Space>G ':vimgrep /\<' . expand('<cword>') . '\>/j **/*.' . expand('%:e')
nnoremap <expr> <Space>uG ':Unite grep:%<CR>' . expand('<cword>')
"nnoremap <expr> <Space>g ':sil grep! ' . expand('<cword>') . ' *'
nnoremap <expr> <Space>ug ':Unite grep:.<CR>' . expand('<cword>')
"noremap gg :sil grep --exclude-dir=CVS --exclude-dir=.svn --exclude-dir=.git --exclude=*.swp "<C-R><C-W>" .<CR> <CR> <C-w><C-w> <C-W>T
"noremap gg :sil grep "<C-R><C-W>" .
"noremap gs /<C-R><C-W><CR>
"imap <nul> <C-x><C-o><C-p>

"autocmd!
"autocmd FileType php vmap // <C-V>#\^I//<ESC>
"autocmd FileType ruby,python vmap // <C-V>OI#<ESC>
"autocmd FileType php vmap <Bslash><Bslash> :s/^\(\s*\t*\)\/\//\1/<CR>:noh<CR>
"autocmd FileType ruby,python vmap <Bslash><Bslash> :s/^\(\s*\t*\)#/\1/<CR>:noh<CR>
"autocmd FileType html,xml,php vmap /b :<ESC>:'<s/\(.*\)/<!--<C-v><C-m>\1/<CR>:<ESC>:'>s/\(.*\)/\1<C-v><C-m>-->/<CR>:noh<CR>
"
"
" colorscheme
"
colorscheme atom-dark-256

"
" Highlighting trailing white space.
"
augroup hilightExtraWhitespace
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace term=underline ctermbg=Red guibg=Red
  autocmd ColorScheme * highlight IdegraphicSpace term=underline ctermbg=Red guibg=Red
  autocmd VimEnter,WinEnter * match ExtraWhitespace /\s\+$/
  autocmd VimEnter,WinEnter * match IdegraphicSpace /　/
augroup END

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
  "autocmd FileType php :set dictionary+=~/.vim/dict/php.dict
  autocmd FileType php let php_sql_query=1
  autocmd FileType php let php_htmlInStrings=1
  autocmd FileType php let php_folding=1
  autocmd FileType php setl fdm=indent
  autocmd FileType php normal zR
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  "autocmd FileType php let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/php.dict'
  "autocmd CmdwinEnter * AutoComplPopDisable
  "autocmd CmdwinLeave * AutoComplPopEnable
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
  augroup END
endif

"
" for ruby, rails
"
"if has("autocmd")
"  autocmd FileType ruby,eruby setl autoindent
"  autocmd FileType ruby,eruby setl expandtab
"  autocmd FileType ruby,eruby setl tabstop=2
"  autocmd FileType ruby,eruby setl shiftwidth=2
"  autocmd FileType ruby,eruby setl softtabstop=2
"  autocmd FileType ruby,eruby let g:rails_level = 4
"  autocmd FileType ruby,eruby let g:rails_syntax = 1
"  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"  "autocmd BufWrite *.rb w !ruby -c
"endif

"
" for python
"
"if has("autocmd")
"  autocmd FileType python setl autoindent
"  autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"  autocmd FileType python setl expandtab
"  autocmd FileType python setl tabstop=4
"  autocmd FileType python setl shiftwidth=4
"  autocmd FileType python setl softtabstop=4
"  autocmd FileType python let g:pydiction_location = '~/.vim/dict/complete-dict'
"endif

"
" for c/c++
"
"if has("autocmd")
"  autocmd FileType c,cpp setl autoindent
"  autocmd FileType c,cpp setl cindent
"  autocmd FileType c,cpp setl tabstop=8
"  autocmd FileType c,cpp setl shiftwidth=8
"  autocmd FileType c,cpp setl noexpandtab
"endif

"
" for xml
"
"if has("autocmd")
  "autocmd Filetype xml,html,php,eruby inoremap <buffer> </ </<C-x><C-o>
"endif

"
" load template
"
augroup templateload
  autocmd!
  autocmd BufNewFile *.html 0r ~/.vim/templates/index.html
augroup END

"augroup phpsyntaxcheck
"  autocmd!
"  autocmd BufWrite *.php w !php -l
"  autocmd BufWrite *.module w !php -l
"  autocmd BufWrite *.inc w !php -l
"augroup END

"
" forcus last position
"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line ("$") | exe "normal! g'\"" | endif

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

NeoBundle 'sudo.vim'
NeoBundle 'https://github.com/b4b4r07/vim-buftabs.git'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides.git'
NeoBundle 'https://github.com/junegunn/vim-easy-align.git'
NeoBundle 'ConradIrwin/vim-bracketed-paste'
"NeoBundle 'https://github.com/tpope/vim-rails.git'
"NeoBundle 'https://github.com/taku-o/vim-vis.git'
NeoBundle 'netrw.vim'
"NeoBundle 'c.vim'
"NeoBundle 'YankRing.vim'
"NeoBundle 'https://github.com/houtsnip/vim-emacscommandline.git'
"NeoBundle 'matchit.zip'
"NeoBundle 'surround.vim'
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
NeoBundle 'https://github.com/thinca/vim-ref.git'
"NeoBundle 'smartchr'
"NeoBundle 'ZenCoding.vim'
NeoBundle 'https://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/SHougo/unite-outline.git'
NeoBundle 'https://github.com/tsukkee/unite-tag.git'
"NeoBundle 'https://github.com/tsukkee/unite-gtags.git'
NeoBundle 'https://github.com/Shougo/vimproc.git'
"NeoBundle 'https://github.com/thinca/vim-visualstar.git'
"NeoBundle 'The-NERD-tree'
"NeoBundle 'Align'
"NeoBundle 'https://github.com/itchyny/calendar.vim.git'
"NeoBundle 'https://github.com/chrisbra/NrrwRgn.git'
"NeoBundle 'https://github.com/vim-scripts/utl.vim.git'
"NeoBundle 'Markdown'
NeoBundle 'https://github.com/scrooloose/nerdtree.git'
"NeoBundle 'https://github.com/scrooloose/syntastic.git'
"NeoBundle 'https://github.com/tpope/vim-pathogen.git'
"NeoBundle 'https://github.com/majutsushi/tagbar.git'
"NeoBundle 'https://github.com/jistr/vim-nerdtree-tabs.git'
"NeoBundle 'https://github.com/krisajenkins/vim-pipe.git'
"NeoBundle 'suan/vim-instant-markdown'

"NeoBundle 'jscomplete-vim'
NeoBundle 'taglist.vim'
"NeoBundle 'quickfixstatus'
"NeoBundle 'vim-hier'
"NeoBundle 'vim-textmanip'
"NeoBundle 'headlights'
"NeoBundle 'trinity.vim'
"NeoBundle 'gtags.vim'
"NeoBundle 'vim-javascript'
"NeoBundle 'csv.vim'
NeoBundle 'https://github.com/joonty/vdebug.git'

"NeoBundle 'https://github.com/hsitz/VimOrganizer.git'
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
"NeoBundle 'https://github.com/thinca/vim-quickrun.git', {
"            \ 'lazy': 1,
"            \ 'autoload': {
"            \   'commands': [{'name': 'QuickRun',
"                            \  'complete': 'customlist,quickrun#complete', }],
"            \   'mappings': ['nxo', '<Plug>(quickrun)'],
"            \ }}

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
" sudo.vim
"
nnoremap <Space>ww :w sudo:%

"
" vim-easy-align
"
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

"
" taglist
"
let g:Tlist_Show_One_File = 1
let g:Tlist_Exit_OnlyWindow = 1
let g:Tlist_GainFocus_On_ToggleOpen = 1
let g:Tlist_Use_Right_Window = 1
nnoremap <silent> <Space>tl :TlistToggle<CR>
let g:tlist_php_settings = 'php;c:class;d:constant;f:function'
au FileType taglist call s:initialize_taglist()
function! s:initialize_taglist()
  setl norelativenumber
endfunction

"
" nerdtree
"
nnoremap <silent> <Space>ne :NERDTreeToggle<CR>

"
" YankRing.vim
"
"let g:yankring_history_dir = expand('~')
"let g:yankring_history_file = '.yankring_history'
"let g:yankring_max_history = 10
"let g:yankring_window_height = 13

"
" matchhit
"
"runtime bundle/matchit.zip/plugin
"let b:match_ignorecase=1
"let b:match_words=&matchpairs . ",if:endif,begin:end,do:end"

"
" indent-guides
"
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_color_change_percent=30
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=darkgrey

"
" smartchr
"
"inoremap <expr> = smartchr#loop(' = ', '=', ' == ')
"inoremap <expr> , smartchr#loop(', ', ',')

"
" vim-instant-markdown-d
"
"let g:instant_markdown_slow = 1


"
" unite-outline
"
nnoremap <Space>uo :Unite -auto-preview -winheight=15 outline<CR>

"
" VimOrganizer
"
"au! BufRead,BufWrite,BufWritePost,BufNewFile *.org
"au BufEnter *.org            call org#SetOrgFileType()
"let g:org_command_for_emacsclient = '/usr/bin/emacs'
"let g:org_agenda_select_dirs=["~/.vim_junk/org_files"]
"let g:org_agenda_files = split(glob("~/.vim_junk/org_files/*.org"),"\n")

"
" xdebug
"
"let g:debuggerMaxDepth = 10

"
" select after paste
"
"nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'


"
" ctags
"
"set tags=~/.tags/tags

"
" vim-pipe
"

"
" QFixGrep
"
"let QFixWin_EnableMode = 1
"let QFix_PreviewEnable = 1
"let QFix_UseLocationList = 1
"let QFix_Height = 30
"let QFix_PreviewOpenCmd = 'vertical leftabove'
"let QFix_CopenCmd = 'vertical topleft'

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
