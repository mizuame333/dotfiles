"===================================
"    _   __(_)___ ___  __________
"   | | / / / __ `__ \/ ___/ ___/
"   | |/ / / / / / / / /  / /__  
"   |___/_/_/ /_/ /_/_/   \___/  
"===================================
"
syntax on
syntax enable
set clipboard+=unnamed
set number
set expandtab
set textwidth=0
set softtabstop=4
set tabstop=4
set shiftwidth=4
set autoindent
set backspace=indent,eol,start
set incsearch
set smartcase
set infercase
set virtualedit=all
set hidden
set colorcolumn=80
" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell
" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set wrap
set showmatch
set matchpairs& matchpairs+=<:>
set hlsearch
set ignorecase
set ruler
set t_Co=256
set wildmenu
set showmode
set commentstring=\ #\ %s
set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>
" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start
" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
    " set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
    set clipboard& clipboard+=unnamedplus,unnamed 
else
    " set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
    set clipboard& clipboard+=unnamed
endif
nnoremap j gj
nnoremap k gk
vnoremap v $h
"Ctrl + hjklでウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set cursorline
"キー設定
"inoremap {} {}<LEFT>
"inoremap [] []<LEFT>
"inoremap () ()<LEFT>
"inoremap "" ""<LEFT>
"inoremap '' ''<LEFT>
"inoremap <> <><LEFT>
"ESCを2回押すとハイライトを消すようにする
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nmap <silent> <Leader>fi :VimFilerBufferDir -split -simple -winwidth=35 -no-quit<CR>
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
"let g:indent_guides_enable_on_vim_startup = 1
"NeoBundle
filetype plugin indent off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle'))
    NeoBundleFetch 'Shougo/neobudle.vim'
    call neobundle#end()
endif
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'vim-scripts/grep.vim'
NeoBundle 'Shougo/unite.vim'
"NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {
      \   "commands": ['GundoToggle'],
      \}}
nnoremap <Leader>g :GundoToggle<CR>
"NeoBundle 'Townk/vim-autoclose'
"
NeoBundleLazy "thinca/vim-quickrun", {
      \ "autoload": {
      \   "mappings": [['nxo', '<Plug>(quickrun)']]
      \ }}
nmap <Leader>r <Plug>(quickrun)
let s:hooks = neobundle#get_hooks("vim-quickrun")
function! s:hooks.on_source(bundle)
  let g:quickrun_config = {
      \ "*": {"runner": "remote/vimproc"},
      \ }
endfunction
" Snippets
"NeoBundle 'SirVer/ultisnips'
"NeoBundle 'honza/vim-snippets'

" Color
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
" Python Bundle
NeoBundle "davidhalter/jedi-vim"
NeoBundle "scrooloose/syntastic"
NeoBundle "majutsushi/tagbar"
"NeoBundle "Yggdroot/indentLine"
"NeoBundle "nathanaelkane/vim-indent-guides"
NeoBundle 'Shougo/neocomplete'
NeoBundle "thinca/vim-template"
"NeoBundle "itchyny/lightline.vim"
" テンプレート中に含まれる特定文字列を置き換える
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
    silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
    silent! %s/<+FILENAME+>/\=expand('%:t')/g
endfunction

autocmd User plugin-template-loaded
\ silent %s/<%=\(.\{-}\)%>/\=eval(submatch(1))/ge
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd User plugin-template-loaded
    \   if search('<+CURSOR+>')
    \ |   silent! execute 'normal! "_da>'

"------------------------------------
"colorscheme
"------------------------------------
colorscheme jellybeans
highlight LineNr ctermfg=3 ctermbg=none 
highlight Normal ctermbg=none
"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

