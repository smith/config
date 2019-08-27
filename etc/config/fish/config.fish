# Fish config

set -gx EDITOR "code --wait"

# Paths
set -gx GOPATH $HOME/.go
set -gx PATH $GOPATH/bin $PATH
set -gx NODE_PATH $PWD/node_modules $HOME/.node_modules \
                  /usr/local/share/npm/lib/node_modules \
                  $NODE_PATH

mkdir -pv \
    "$GOPATH/bin" \
    "$HOME/.rbenv/bin" \
    "$HOME/.rbenv/shims" \
    "$HOME/bin"

set -gx PATH \
    $GOPATH/bin \
    $HOME/.rbenv/bin \
    $HOME/.rbenv/shims \
    $HOME/bin \
    $PATH

set -gx NODE_PATH \
    $PWD/node_modules \
    $HOME/.node_modules \
    $NODE_PATH

# Ruby bin path
if which ruby > /dev/null
  set -gx PATH (ruby -rubygems -e 'puts Gem.user_dir')/bin $PATH
end

# rbenv
if which rbenv >/dev/null
    rbenv init - | source
    set gem_user_dir (ruby -rubygems -e 'puts Gem.user_dir')
    mkdir -p $gem_user_dir/bin
    set -gx PATH $gem_user_dir/bin $PATH
end

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
if type -q bass; and test -e ~/.nvm/nvm.sh
  bass source ~/.nvm/nvm.sh
  function nvm
    bass source ~/.nvm/nvm.sh ';' nvm $argv
  end
end

# SSH Agent setup. Taken from https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
         ssh-add
         if [ $status -eq 2 ]
             start_agent
         end
    end
end

if [ -n "$SSH_AGENT_PID" ]
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
         test_identities
    end
else
    if [ -f $SSH_ENV ]
         . $SSH_ENV > /dev/null
    end
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
         test_identities
    else
         start_agent
    end
end
