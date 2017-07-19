" Nathan L Smith's .vimrc
" http://github.com/smith/vim-config/

syntax on
set nocompatible
set shell=/bin/bash

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'airblade/vim-gitgutter'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'burnettk/vim-angular'
Bundle 'cespare/vim-toml'
Bundle 'Chiel92/vim-autoformat'
Bundle 'dag/vim-fish'
Bundle 'digitaltoad/vim-jade'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'elzr/vim-json'
Bundle 'gcmt/wildfire.vim'
Bundle 'gmarik/vundle'
Bundle 'guns/vim-clojure-static'
Bundle 'guns/vim-sexp'
Bundle 'hashivim/vim-terraform'
Bundle 'HerringtonDarkholme/vim-worksheet'
Bundle 'idanarye/vim-merginal'
Bundle 'int3/vim-extradite'
Bundle 'jpalardy/vim-slime'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'lambdatoast/elm.vim'
Bundle 'leafgarland/typescript-vim'
Bundle 'low-ghost/nerdtree-fugitive'
Bundle 'majutsushi/tagbar'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'osyo-manga/vim-monster'
Bundle 'othree/html5.vim'
Bundle 'othree/javascript-libraries-syntax.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'plasticboy/vim-markdown'
Bundle 'Quramy/tsuquyomi'
Bundle 'rhysd/committia.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'rizzatti/funcoo.vim'
Bundle 'roalddevries/yaml.vim'
Bundle 'rust-lang/rust.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc.vim'
"Bundle 'SirVer/ultisnips'
Bundle 'slim-template/vim-slim'
Bundle 'tpope/vim-classpath'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-leiningen'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-tbone'
Bundle 'vim-ruby/vim-ruby'
Bundle 'wakatime/vim-wakatime'
Bundle 'wellle/tmux-complete.vim'
Bundle 'Xuyuanp/nerdtree-git-plugin'
" This must be loaded after vim-ruby
Bundle 'file:///Users/nathansmith/Projects/vim-chef'

Bundle 'Align'
Bundle 'csv.vim'
Bundle 'LargeFile'
Bundle 'TaskList.vim'
Bundle 'TwitVim'
Bundle 'ZoomWin'

filetype plugin indent on

" General options
set autoread
set clipboard=unnamed
set hidden
set incsearch
set ignorecase
set lazyredraw
set mouse=a
set nobackup
set noswapfile
set smartcase
set spell
set spelllang=en_us
set showcmd
set splitbelow
set splitright
set switchbuf=useopen
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set history=1000
set pastetoggle=<F2>
set shortmess=at
set tags=./tags;/
set t_Co=256

" Status line
set laststatus=2 " Always show
" filename [modified (+ or -)] [fugitive info] [filetype]              row,col %
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Use :w!! to save with sudo if you're editing a readonly file
cmap w!! w !sudo tee % >/dev/null

" Key Mappings
let mapleader=","
let g:mapleader=","

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" CoffeeScript
"
" Given :C NN, compile the coffeescript and go to the line in the JS
command! -nargs=1 C CoffeeCompile | :<args>

" <CTRL-P> for ctrlp.vim
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlPMRUFiles'

" remap shift tab to be omni-complete
inoremap <S-TAB> <C-X><C-O>

" use <C-W><C-Z> for zoomwin
nmap <C-W>z  <Plug>ZoomWin

" Slime
let g:slime_target = "tmux"

" GUI options
if has("gui_running")
  " No menus and no toolbar
  set guioptions-=m
  set guioptions-=T

  " Left handed scrollbar
  set guioptions-=r
  set guioptions+=l

  set co=80
  set lines=45
endif

" Appearance
set ruler
set title
set wrap
if exists("+colorcolumn")
  set colorcolumn=81
endif
set cursorline
set scrolloff=3
colorscheme desert256

" Fix folded highlight in terminal
highlight Folded ctermfg=Yellow ctermbg=NONE
highlight FoldColumn ctermfg=Yellow ctermbg=NONE

" Highlight trailing whitespace
highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au ColorScheme * highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au BufWinEnter * match ExtraWhitespace /\s\+$\|\t\+/
au BufWrite * match ExtraWhitespace /\s\+$\|\t\+/

" Spelling highlights
highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=red

" bats!
au BufRead,BufNewFile,BufWrite {*.bats} set ft=sh

" CSS-type things
au BufRead,BufNewFile,BufWrite {*.less} set ft=css

" CoffeeScript
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '--include-vars',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

" Erlang
au Filetype erlang setlocal shiftwidth=4
au Filetype erlang setlocal softtabstop=4
au Filetype erlang setlocal tabstop=4

" Git shortcuts
function! s:GitCheckout(...)
  :silent execute 'Git checkout ' . a:1 . ' > /dev/null 2>&1' | redraw!
endfunction
command! -nargs=1 Gc call s:GitCheckout(<f-args>)
" http://robots.thoughtbot.com/post/48933156625/5-useful-tips-for-a-better-commit-message
au Filetype gitcommit setlocal spell textwidth=72

" Handlebars/mustache
let g:mustache_abbreviations = 1

" Markdown
au BufRead,BufNewFile,BufWrite {*.markdown,*.md,*.mdk} set ft=markdown
au FileType markdown setlocal makeprg=ghpreview\ %
au BufRead,BufNewFile,BufWrite {*.textile} set ft=textile

" Property lists
au BufRead,BufNewFile,BufWrite {*.plist} set ft=xml

" Syntastic mods
let g:syntastic_coffee_coffeelint_args = "--csv --file ~/.coffeelintrc"
let g:syntastic_sh_shellcheck_args = "--shell=bash --exclude=SC1090,SC1091,SC2034,SC2039,SC2148,SC2153,SC2154"

" Use ruby syntax for additional ruby types
au BufRead,BufNewFile,BufWrite {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = 'chef exec chefstyle'

" Indent-based folding
au BufRead,BufNewFile,BufWrite {*.json,,*.py,*.coffee,*.yaml,*.yml} set foldmethod=indent

" FIXME: This fails when you have Prototype.js style string inteporation like
"        #{prop} in a string
function! JavaScriptFold()
  setl foldmethod=syntax
  setl foldlevelstart=99
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

  function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldtext=FoldText()
endfunction

" Lisp
au BufRead,BufNewFile,BufWrite {*.scm,*.scheme} set ft=lisp
au BufRead,BufNewFile,BufWrite {*.cljs} set ft=clojure
au BufRead,BufNewFile,BufWrite {*.clj,*.cljs} set nospell
let g:vimclojure#HighlightBuiltins=1      " Highlight Clojure's builtins

" Markdown
let g:formatdef_markdown = 'markdownfmt'
let g:formatters_markdown = ['markdown']

" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Lightblue',   'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['Lightblue',   'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Lightblue',   'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" Rust
let g:rustfmt_autosave = 0
let g:formatdef_rustfmt = '"rustfmt"'
let g:formatters_rust = ['rustfmt']

" Make gf work for Common JS and AMD modules
au FileType javascript setlocal suffixesadd=.coffee,.js,.jade
au FileType coffee setlocal suffixesadd=.coffee ",.js,.jade

" FIXME: When js in rails projects is being edited, it uses 2 spaces. Figure
"        out how to not have rails.vim override this
au FileType javascript call JavaScriptFold()
au FileType coffee,javascript setlocal makeprg=npm\ test
au FileType javascript setl fen
au FileType javascript setl foldlevel=99

au FileType json setlocal equalprg=jsonlint
let g:vim_json_syntax_conceal = 0

" TypeScript
let g:tagbar_type_typescript = {
  \ 'ctagstype': 'typescript',
  \ 'kinds': [
    \ 'c:classes',
    \ 'n:modules',
    \ 'f:functions',
    \ 'v:variables',
    \ 'v:varlambdas',
    \ 'm:members',
    \ 'i:interfaces',
    \ 'e:enums',
  \ ]
\ }

let g:syntastic_typescript_checkers = ['tslint', 'tsc']
" Invoking `tsc` with no arguments makes it so a tsconfig.json is read if it
" is present.
let g:syntastic_typescript_tsc_fname = ''

" MacVim
if has("gui_macvim")
  set transp=1
  set anti enc=utf-8 gfn=Source_Code_Pro:h16,Menlo:h14,Monaco:h14
  set fuoptions=maxvert,maxhorz

  " Copy/paste on mac
  " (http://www.drbunsen.org/text-triumvirate.html#vim)
  " Yank text to the OS X clipboard
  noremap <leader>y "*y
  noremap <leader>yy "*Y
  " Preserve indentation while pasting text from the OS X clipboard
  noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
endif

" Windows
if has("win32")
    " Use CUA keystrokes for clipboard: CTRL-X, CTRL-C, CTRL-V and CTRL-z
    source $VIMRUNTIME/mswin.vim
    set guifont=Consolas:h13:cANSI,Anonymous\ Pro:h13:cANSI
endif

" See http://robots.thoughtbot.com/faster-grepping-in-vim/ for the below

" The Silver Searcher
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s --files --color never ""'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Leader mappings
"
" NERDTree toggle with ,`
map <leader>` :NERDTreeToggle<CR>
" :Align = with ,=, :Align and sort with ,+
map <leader>= :Align =<CR>
" TagBar with ,\
map <leader>\ :TagbarToggle<CR>
" Resize window to 80 width with ,8
map <leader>8 :vertical resize 80<CR>
" Autoformat
nmap <Leader>a :Autoformat<CR>
" ,d for dispatch
map <leader>d :Dispatch<CR>
" ,f to find in nerdtree
map <leader>f :NERDTreeFind<CR>
" Dash
nmap <silent> <leader>h <Plug>DashSearch
nmap <silent> <leader>H <Plug>DashGlobalSearch
" ,n to insert the time, 'n'ow
map <leader>n "=strftime("%FT%T%z")<CR>Pa<SPACE>
" TypeScript
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
" CoffeeCompile
vmap <leader>s <esc>:'<,'>:CoffeeCompile<CR>
map <leader>s :CoffeeCompile<CR>
