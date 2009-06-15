" Nathan L Smith's .vimrc file. Based on
" John Lam's .vimrc file

" Use ruby syntax for capfiles
au BufNewFile,BufRead capfile	setf ruby

syntax on
set nocompatible
set autoread
filetype on
filetype indent on
filetype plugin on

" General options
set incsearch
set ignorecase smartcase 
set backupdir=/tmp

" Use four space tabs
set tabstop=4
set shiftwidth=4
set expandtab

" Set GUI options
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

" Setup 80 column word wrap
set wrap 

set ruler
set bg=dark

highlight Normal guifg=White   guibg=Black
highlight Cursor guifg=Black   guibg=Yellow
highlight Keyword guifg=#FF6600
highlight Define guifg=#FF6600
highlight Comment guifg=#9933CC
highlight Type guifg=White gui=NONE
highlight rubySymbol guifg=#339999 gui=NONE
highlight Identifier guifg=White gui=NONE
highlight rubyStringDelimiter guifg=#66FF00
highlight rubyInterpolation guifg=White
highlight rubyPseudoVariable guifg=#339999
highlight Constant guifg=#FFEE98
highlight Function guifg=#FFCC00 gui=NONE
highlight Include guifg=#FFCC00 gui=NONE
highlight Statement guifg=#FF6600 gui=NONE
highlight String guifg=#66FF00
highlight Search guibg=White

function RubyEndToken ()
  let current_line = getline( '.' )
  let braces_at_end = '{\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  let stuff_without_do = '^\s*\(class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def\)'
  let with_do = 'do\s*\(|\(,\|\s\|\w\)*|\s*\)\?$'
  if match(current_line, braces_at_end) >= 0
    return "\<CR>}\<C-O>O" 
  elseif match(current_line, stuff_without_do) >= 0
    return "\<CR>end\<C-O>O" 
  elseif match(current_line, with_do) >= 0
    return "\<CR>end\<C-O>O" 
  else
    return "\<CR>" 
  endif
endfunction

function UseRubyIndent ()
  setlocal tabstop=8
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
  imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
endfunction

autocmd FileType ruby,eruby call UseRubyIndent()

map ,# :s/^/#/<CR>
map <M-]> :tabnext<CR>
map <M-[> :tabprevious<CR>
map <M-t> :tabnew<CR>
imap <M-]> :tabnext<CR>
imap <M-[> :tabprevious<CR>
imap <M-t> :tabnew<CR>

" Enable JavaScript code folding
function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=99
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl foldlevel=99

" Enable PHP folding
let php_folding=1
au FileType php setl foldlevel=99

" MacVim Specific options
if has("gui_macvim")
    set transp=1
    set anti enc=utf-8 tenc=macroman gfn=Monaco:h14
endif

" Windows Specific options
if has("win32")
    set backupdir=c:\temp
    set guifont=Consolas:h13:cANSI
endif
