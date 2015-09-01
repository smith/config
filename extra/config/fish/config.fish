# Fish config

set -gx EDITOR vim

# Paths
set -gx PATH /opt/chefdk/bin $HOME/bin $PWD/node_modules/.bin $HOME/.rbenv/bin \
             $HOME/.rbenv/shims /usr/local/share/npm/bin \
             $PATH
set -gx NODE_PATH $PWD/node_modules $HOME/.node_modules \
                  /usr/local/share/npm/lib/node_modules \
                  $NODE_PATH

# rbenv
set -gx RBENV_ROOT $HOME/.rbenv

# lastpass aliases
if which lpass > /dev/null
  function adpw; command lpass show --clip --password "Chef AD"; end
end

# ls/open aliases; set ls colors
if [ (uname) = "Darwin" ]
    set -gx LSCOLORS Dxfxcxdxbxegedabagacad
    function ls; command ls -FGh $argv; end
    function o; open $argv; end
else
    function ls; command ls -Fh --color=auto; end
    function o; $EDITOR $argv; end
end

# Alias mvim (MacVim) to vim and make EDITOR if available
if which mvim > /dev/null
    function vi; mvim -v $argv; end
    function vim; vi $argv; end
end

# ChefDK
eval (chef shell-init SHELL_NAME)

# Use dfc if available
if which dfc > /dev/null; function df; dfc; end; end

# direnv
eval (direnv hook fish)

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

test -s /Users/nathansmith/.nvm-fish/nvm.fish; and source /Users/nathansmith/.nvm-fish/nvm.fish
