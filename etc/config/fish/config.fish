# Fish config

set -gx EDITOR "code --wait"

# Paths
# set -gx GOPATH $HOME/.go
# set -gx PATH $GOPATH/bin $PATH
# set -gx NODE_PATH $PWD/node_modules $HOME/.node_modules \
#                  /usr/local/share/npm/lib/node_modules \
#                  $NODE_PATH

# set -gx GOBIN (go env GOPATH)/bin

mkdir -pv \
#    "$GOPATH/bin" \
#    "$HOME/.rbenv/bin" \
#    "$HOME/.rbenv/shims" \
    "$HOME/bin"

set -gx PATH \
#    $GOPATH/bin \
#    $HOME/.rbenv/bin \
#    $HOME/.rbenv/shims \
    /opt/homebrew/bin \
    $HOME/bin \
    /Applications/Docker.app/Contents/Resources/bin \
    $HOME/code/weaver/target/debug \
    $PATH

# set -gx NODE_PATH \
#    $PWD/node_modules \
#    $HOME/.node_modules \
#    $NODE_PATH

function fish_prompt                    
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n '> '
end

# Ruby bin path
# if which ruby > /dev/null
#   set -gx PATH (ruby -rubygems -e 'puts Gem.user_dir')/bin $PATH
# end

# rbenv
# if which rbenv >/dev/null
#     rbenv init - | source
#     set gem_user_dir (ruby -rubygems -e 'puts Gem.user_dir')
#     mkdir -p $gem_user_dir/bin
#     set -gx PATH $gem_user_dir/bin $PATH
# end

# ls/open aliases; set ls colors
if [ (uname) = "Darwin" ]
    set -gx LSCOLORS Dxfxcxdxbxegedabagacad
    function ls; command ls -FGh $argv; end
else
    function ls; command ls -Fh --color=auto $argv; end
end

# Alias nvim (Neovim) to vim and make EDITOR if available
# if which nvim > /dev/null
#     function vi; nvim $argv; end
#     function vim; nvim $argv; end
# end

# ChefDK
# if which chef > /dev/null; eval (chef shell-init fish); end

# Use dfc if available
# if which dfc > /dev/null; function df; dfc; end; end

# direnv
if which direnv > /dev/null; eval (direnv hook fish); end

# lisp
if which clj > /dev/null; function lisp; rlwrap clj; end; end

# lolcat
if which lolcat > /dev/null; function cat; lolcat $argv; end; end

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

# NVM
if type -q bass; and test -e /opt/homebrew/opt/nvm/nvm.sh
  bass source /opt/homebrew/opt/nvm/nvm.sh
  function nvm
    bass source /opt/homebrew/opt/nvm/nvm.sh ';' nvm $argv
  end
end
test -f "/Library/Scripts/elastic-env.fish" && source "/Library/Scripts/elastic-env.fish"

# Google Cloud SDK
set -gx CLOUDSDK_PYTHON /opt/homebrew/bin/python3
test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc; and source /opt/homebrew/share/google-cloud-sdk/path.fish.inc

# Created by `pipx` on 2025-05-04 04:26:10
set PATH $PATH /Users/smith/.local/bin

mise activate fish | source
