# Is Brew installed?
if ! which brew > /dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # add to path
  echo "Adding Homebrew to PATH"
  echo "👀 checking shell environment..."
  if [ -n "$BASH_VERSION" ]; then
    echo "Running in Bash"
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
  elif [ -n "$ZSH_VERSION" ]; then
    echo "Running in Zsh"
    echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
  else
    echo "⚠️⚠️⚠️ Running in an unknown shell ⚠️⚠️⚠️"
    echo "brew won't work until you add this to your rc file"
    echo 'export PATH="/usr/local/bin:$PATH"'
    export PATH="/usr/local/bin:$PATH"
  fi
fi

echo "Installing Homebrew packages"

echo "===Workflow Essentials==="
brew install --cask wezterm
brew install --cask docker
brew install --cask rectangle
brew install --cask karabiner-elements
brew install yqrashawn/goku/goku
brew install --cask visual-studio-code
brew tap espanso/espanso
brew install espanso
brew install starship
# Install Keyboard Maestro 9.2 here: https://files.stairways.com/

echo "===Development==="
brew install npm
brew install node
brew install minikube
brew install kubectl
brew install golang
brew install tig

# Rust
if ! which rustup > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "===Applications==="
brew install --cask spotify
# brew install --cask tuple
brew install --cask vlc
brew install --cask keycastr
brew install --cask tomatobar # Pomo timer

echo "===Fonts==="
# https://dtinth.github.io/comic-mono-font/

