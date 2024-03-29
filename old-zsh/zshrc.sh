# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history

	git config --global push.default current

# Aliases
	alias la="ls -A"
	alias x="clear"
	alias v="vim -p"
	alias tmux="TERM=screen-256color-bce tmux"
	mkdir -p /tmp/log

	## fasd 
	alias a='fasd -a'        # any
	alias s='fasd -si'       # show / search / select
	alias d='fasd -d'        # directory
	alias f='fasd -f'        # file
	alias sd='fasd -sid'     # interactive directory selection
	alias sf='fasd -sif'     # interactive file selection
	alias z='fasd_cd -d'     # cd, same functionality as j in autojump
	alias zz='fasd_cd -d -i' # cd with interactive selection

	## git shorthand
	alias ga='git add .'	 # add all
	alias gc='git commit'	 # commit with commitizen
	alias gs='git status'	 

	## docker shorthand
	alias dcu='docker-compose up'	# docker-compose up
	alias dcd='docker-compose down'	# docker-compose down

	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	# `mktouch foo/bar/baz.txt` -> `mkdir -p foo/bar/ && touch baz.txt`
	function mktouch() {
	    if [ $# -lt 1 ]; then
		echo "Missing argument";
		return 1;
	    fi

	    for f in "$@"; do
		mkdir -p -- "$(dirname -- "$f")"
		touch -- "$f"
	    done
	}

	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output 
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

 	# Custom cd
 	c() {
 		cd $1;
 		ls;
 	}
 	alias cd="c"

# For vim mappings: 
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

plugins=(
	docker
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

#for plugin ($plugins); do
#    fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
#done

autoload -U compinit && compinit

#source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
#source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
#source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
#source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
#source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh
# export PATH=$PATH:$HOME/dotfiles/utils
# homebrew packages
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/dotfiles/utils
export JAVA_HOME=$HOME/Java/jdk-11.0.2.jdk/Contents/Home

path=("/usr/local/sbin" $path)
path=("${HOME}/bin" $path)
typeset -aU path
