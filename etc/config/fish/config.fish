# Fish config

set -gx EDITOR nvim

# Paths
set -gx GOPATH $HOME/go
#set -gx PATH /usr/local/share/dotnet /opt/chefdk/bin $HOME/bin \
             #$PWD/node_modules/.bin $HOME/.cargo/bin \
             #$HOME/.rbenv/bin $HOME/.rbenv/shims /usr/local/share/npm/bin \
             #$GOPATH/bin $HOME/google-cloud-sdk/bin \
             #/Applications/Postgres.app/Contents/Versions/9.6/bin \
             #$PATH
set -gx PATH $GOPATH/bin $PATH
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
    function ls; command ls -Fh --color=auto $argv; end
    function o; $EDITOR $argv; end
end

# Alias nvim (Neovim) to vim and make EDITOR if available
if which nvim > /dev/null
    function vi; nvim $argv; end
    function vim; nvim $argv; end
end

# ChefDK
#eval (chef shell-init fish)

# Use dfc if available
if which dfc > /dev/null; function df; dfc; end; end

# direnv
#eval (direnv hook fish)

# docker
# eval (docker-machine env default)

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

# Edit command bindings
function edit_cmd --description 'Input command in external editor'
		set -l f (mktemp /tmp/fish.cmd.XXXXXXXX)
		if test -n "$f"
				set -l p (commandline -C)
				commandline -b > $f
				vim -c 'set ft=fish' $f
				commandline -r (more $f)
				commandline -C $p
				command rm $f
		end
end

# Would like to bind this to ctrl-shift-e but can't figure out how to do shift
function fish_user_key_bindings
  #bind \cE 'edit_cmd'
end

# Use multiple SSH configs
function ssh
  cat ~/.ssh/config.d/* > ~/.ssh/config
  command ssh $argv
end

# Docker
#function dcd
  #docker-compose down $argv
#end

#function dcdev
  #docker-compose --file $HOME/Projects/automate/lunchtime-poc/docker-compose.yml --file $HOME/Projects/automate/lunchtime-poc/docker-compose.dev.yml --file $HOME/Projects/automate/lunchtime-poc/docker-compose.local.yml $argv
#end

# NVM
#bass source ~/.nvm/nvm.sh
#function nvm
  #bass source ~/.nvm/nvm.sh ';' nvm $argv
#end

# Visual Studio Code
function code
  set VSCODE_CWD "$PWD"
  open -n -b "com.microsoft.VSCode" --args $argv
end
#source ~/.asdf/asdf.fish
