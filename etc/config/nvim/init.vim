" Nathan L Smith's Vim configuration. Neovim-specific. Avaliable at
" https://github.com/smith/config.

" Set up vim-plug for plugins. Run:
"
"    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" :PlugInstall will install plugins.
call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'brafales/vim-desert256'
Plug 'cespare/vim-toml'
Plug 'dougireton/vim-chef'
Plug 'low-ghost/nerdtree-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neomake/neomake'
Plug 'PProvost/vim-ps1'
Plug 'rhysd/committia.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'troydm/zoomwintab.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

colorscheme desert256

set clipboard+=unnamedplus " Use the system clipboard
set colorcolumn=81
set expandtab
set ignorecase
set list
set listchars=tab:➝∣,trail:❀
set mouse=a " Normal, Visual, Insert, and Command-line modes
set nobackup
set noswapfile
set shell=/bin/bash
set shiftwidth=2
set softtabstop=2
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set tabstop=2
filetype plugin indent on

let mapleader=","
map <leader>` :NERDTreeToggle<CR>
" Resize window to 80 width with ,8
map <leader>8 :vertical resize 80<CR>
" ,f to find in nerdtree
map <leader>f :NERDTreeFind<CR>
map <leader>z :ZoomWinTabToggle<CR>

" crontab
"
" Crontab will fail to save without these settings
autocmd filetype crontab setlocal nobackup nowritebackup

" ctrlp.vim
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlPMRUFiles'

" Git
autocmd Filetype gitcommit setlocal spell textwidth=72

" JavaScript
let g:neomake_javascript_enabled_makers = ['eslint']

" Neomake
autocmd! BufWritePost * Neomake

" ripgrep
if executable('rg')
  " Use rg over grep
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s --files --color never ""'

  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Ruby
let g:neomake_ruby_rubocop_maker = {
  \ 'args': ['--format', 'emacs'],
  \ 'errorformat': '%f:%l:%c: %t: %m,%E%f:%l: %m',
  \ 'postprocess': function('neomake#makers#ft#ruby#RubocopEntryProcess'),
  \ 'exe': 'chefstyle',
  \ }

" Use cookstyle instead of chefstyle for cookbooks
autocmd Filetype ruby.chef :let g:neomake_ruby_rubocop_maker = {
  \ 'args': ['--format', 'emacs'],
  \ 'errorformat': '%f:%l:%c: %t: %m,%E%f:%l: %m',
  \ 'postprocess': function('neomake#makers#ft#ruby#RubocopEntryProcess'),
  \ 'exe': 'cookstyle',
  \ }

" Use ruby.chef filetype for Berksfile
autocmd BufRead,BufNewFile Berksfile setfiletype ruby.chef

" YAML
autocmd Filetype yaml :set foldmethod=indent
