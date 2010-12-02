" Nathan L Smith's .vimrc
" http://github.com/smith/vim-config/

" Pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

syntax on
filetype plugin indent on

" General options
set autoread
set hidden
set incsearch
set ignorecase
set nobackup
set noswapfile
set smartcase
set spell
set spelllang=en_us
set wildmenu
set wildmode=list:longest
set backspace=indent,eol,start
set history=1000
set shortmess=at
set tags=./tags;/

" Status line
set laststatus=2 " Always show
" filename [modified (+ or -)] [fugitive info] [filetype]              row,col %
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P

" Tabs
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Use :w!! to save with sudo if you're editing a readonly file
cmap w!! w !sudo tee % >/dev/null

" Key Mappings

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
" (stolen from Janus)
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

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
set cursorline
set scrolloff=3
colorscheme desert

" Fix folded highlight in terminal
highlight Folded ctermfg=Yellow ctermbg=NONE
highlight FoldColumn ctermfg=Yellow ctermbg=NONE

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

" Markdown
au BufRead,BufNewFile {*.markdown,*.md,*.mdk} set ft=markdown

" Ruby

" Use ruby syntax for addition ruby types
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

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

" JSON
au! BufRead,BufNewFile *.json setfiletype javascript

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
    set fuoptions=maxvert,maxhorz
endif

" Windows
if has("win32")
    " Use CUA keystrokes for clipboard: CTRL-X, CTRL-C, CTRL-V and CTRL-z
    source $VIMRUNTIME/mswin.vim
    set guifont=Consolas:h13:cANSI,Anonymous\ Pro:h13:cANSI
endif
