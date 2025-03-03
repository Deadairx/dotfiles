# Is Brew installed?
if ! which brew > /dev/null; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # add to path
  echo "Adding Homebrew to PATH"
  echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
  source ~/.bash_profile
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

echo "===Development==="
brew install npm
brew install node
brew install minikube
brew install kubectl
brew install golang
brew install tig

echo "===Applications==="
brew install --cask spotify
# brew install --cask tuple
brew install --cask vlc


echo "===Fonts==="

