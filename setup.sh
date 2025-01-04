#!/bin/bash

echo "Checking for zsh..."
if [ -e /bin/zsh ]; then
  echo "Terminal running zsh successfully"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Install useful tools
  brew install htop
  brew install gotop
  brew install ripgrep
  brew install bat
  brew install wget
  brew install tree
  brew install jq
  
  echo "Installing oh-my-zsh and required fonts"
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts && ./install.sh
  cd .. && rm -rf fonts
  
  echo "Moving oh-my-zsh ~/.zshrc file to ~/.zshrc.oh-my-zsh"
  mv ~/.zshrc ~/.zshrc.oh-my-zsh
  if [ ! -e ~/.zshrc.pre-oh-my-zsh ]; then
    echo "No prior ~/.zshrc file found"
    echo "source ~/.zshrc.oh-my-zsh" > ~/.zshrc
  else
    echo -e "source ~/.zshrc.oh-my-zsh\nsource ~/.zshrc.pre-oh-my-zsh" > ~/.zshrc
  fi
  echo "All set up!"
fi

# Ask for coding languages
read -p "Enter the coding languages you use (comma-separated): " languages

# Convert comma-separated string to array
IFS=',' read -r -a langArray <<< "$languages"

# Install dependencies based on languages
for lang in "${langArray[@]}"; do
  case $(echo "$lang" | tr '[:upper:]' '[:lower:]') in
    python)
      echo "Installing Python and related tools"
      brew install python
      pip install --upgrade pip
      pip install virtualenv
      ;;
    javascript|node|nodejs)
      echo "Installing Node.js and npm"
      brew install node
      npm install -g npm
      ;;
    ruby)
      echo "Installing Ruby and bundler"
      brew install ruby
      gem install bundler
      ;;
    java)
      echo "Installing Java and Maven"
      brew install openjdk
      brew install maven
      ;;
    go|golang)
      echo "Installing Go"
      brew install go
      ;;
    rust)
      echo "Installing Rust"
      brew install rust
      ;;
    *)
      echo "No specific installations for $lang"
      ;;
  esac
done

echo "Setup complete!"