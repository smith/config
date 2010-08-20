" Nathan L Smith's .vimrc
" http://github.com/smith/vim-config/

syntax on
filetype on
filetype indent on
filetype plugin on

" General options
set autoread
set hidden
set incsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set backupdir=/tmp
set history=1000
set shortmess=at
set tags=./tags;/

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Key Mapping : Nothing to see here

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
set scrolloff=3
colorscheme desert

" Highlight trailing whitespace
highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au ColorScheme * highlight ExtraWhitespace guibg=DarkCyan ctermbg=Blue
au BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
au BufWrite * match ExtraWhitespace /\s\+$\| \+\ze\t/

function! Indent4Spaces()
  set tabstop=4
  set softtabstop=4
  set shiftwidth=4
endfunction

" Ruby

" Use ruby syntax for capfiles
" FIXME: These don't work and I don't know why
au BufNewFile, BufRead Capfile setf ruby
au BufNewFile, BufRead .caprc setf ruby

" JavaScript
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

" FIXME: When js in rails projects is being edited, it uses 2 spaces. Figure
"        out how to not have rails.vim override this
au FileType javascript call Indent4Spaces()
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl foldlevel=99

" PHP
let php_folding=1
au FileType php call Indent4Spaces()
au FileType php setl foldlevel=99

" ConqueTerm
function! s:Terminal()
  execute 'ConqueTermSplit bash --login'
endfunction
command! Terminal call s:Terminal()

" MacVim
if has("gui_macvim")
    set transp=1
    set anti enc=utf-8 gfn=Menlo:h14,Monaco:h14
endif

" Windows
if has("win32")
    " Use CUA keystrokes for clipboard: CTRL-X, CTRL-C, CTRL-V and CTRL-z
    source $VIMRUNTIME/mswin.vim

    set backupdir=c:\temp,.
    set guifont=Consolas:h13:cANSI,Anonymous\ Pro:h13:cANSI
endif
