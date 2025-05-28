# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Personal bins
export PATH="$HOME/bin:$PATH"

# Python (pip)
export PATH="$HOME/Library/Python/3.8/bin:$PATH"

# Dotnet
export PATH="/usr/local/share/dotnet:$PATH"

# Flutter
export PATH="/Users/codyarnold/repos/TradeAide/flutter/bin:$PATH"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="random"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  dotenv
  git
  git-auto-fetch
  kubectl
  wd
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
)

PATH=$HOME/Library/Python/3.8/bin:$PATH
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/.emacs.d/bin:$PATH
GOPATH=$(go env GOPATH)
PATH=$GOPATH/bin:$PATH
# add Mason bin
PATH=$HOME/.local/share/nvim/mason/bin:$PATH


EDITOR=/opt/homebrew/bin/nvim

source ~/.credentials

# TODO Source from a .stream_assets file

source $ZSH/oh-my-zsh.sh

bindkey -s ^f "tmux-sessionizer\n"

alias x=clear
alias c=cd
alias vim=nvim
alias gs=gss
alias ls=eza
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



random_md() {
  # Find all markdown files in the current directory
  local files=(*.md)

  # Check if there are any markdown files
  if (( ${#files[@]} == 0 )); then
    echo "No markdown files found in the current directory."
    return 1
  fi

  # Select a random file from the list
  local random_file=${files[$RANDOM % ${#files[@]}]}

  echo "Displaying $random_file:"
  echo "=========================="

  # Count the number of lines in the file
  local line_count=$(wc -l < "$random_file")

  # Display the file with 'cat' if it's under 40 lines, otherwise use 'less'
  if (( line_count > 20 )); then
    less "$random_file"
  else
    cat "$random_file"
  fi
}

# Blank pager for GitHub CLI to send output to stdout instead of less
export GH_PAGER=

# VCV Rack Dev
# Download at https://vcvrack.com/manual/Building#Building-Rack-plugins
export RACK_DIR="$HOME/Rack-SDK"

# pnpm
export PNPM_HOME="/Users/carnold/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
