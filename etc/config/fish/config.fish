# Fish config

set -gx EDITOR nvim

# Paths
set -gx GOPATH $HOME/go

mkdir -pv \
    "$GOPATH/bin" \
    "$HOME/.rbenv/bin" \
    "$HOME/.rbenv/shims" \
    "$HOME/bin"

set -gx PATH \
    $GOPATH/bin \
    $HOME/.rbenv/bin \
    $HOME/.rbenv/shims \
    $PATH

set -gx NODE_PATH \
    $PWD/node_modules \
    $HOME/.node_modules \
    $NODE_PATH

# rbenv
set -gx RBENV_ROOT $HOME/.rbenv

# ls/open aliases; set ls colors
if [ (uname) = "Darwin" ]
    set -gx LSCOLORS Dxfxcxdxbxegedabagacad
    function ls; command ls -FGh $argv; end
else
    function ls; command ls -Fh --color=auto $argv; end
end

# Alias nvim (Neovim) to vim and make EDITOR if available
if which nvim > /dev/null
    function vi; nvim $argv; end
    function vim; nvim $argv; end
end

# ChefDK
if which chef > /dev/null; eval (chef shell-init fish); end

# Use dfc if available
if which dfc > /dev/null; function df; dfc; end; end

# direnv
if which direnv > /dev/null; eval (direnv hook fish); end

# lisp
if which clj > /dev/null; function lisp; rlwrap clj; end; end

# lolcat
if which lolcat > /dev/null; function cat; lolcat $argv; end; end

# hub
if which hub > /dev/null; function git; hub $argv; end; end

# Git prompt parameters
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_informative_status 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_char_dirtystate '*'

function fish_right_prompt; __fish_git_prompt; end

# Use multiple SSH configs
function ssh
  cat ~/.ssh/config.d/* > ~/.ssh/config
  command ssh $argv
end

# NVM
if test (which bass > /dev/null; and test -e ~/.nvm/nvm.sh)
  bass source ~/.nvm/nvm.sh
  function nvm
    bass source ~/.nvm/nvm.sh ';' nvm $argv
  end
end

# Visual Studio Code
#function code
  #set VSCODE_CWD "$PWD"
  #open -n -b "com.microsoft.VSCode" --args $argv
#end
