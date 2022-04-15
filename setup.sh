#!/bin/bash

echo Checking for zsh...
if [ -e /bin/zsh ]
then
  echo Terminal running zsh successfully 
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install htop
  brew install gotop
  brew install ripgrep
  brew install bat
  echo Installing oh-my-zsh and required texts
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts && ./install.sh
  cd .. && rm -rf fonts
  echo Moving oh-my-zsh ~/.zshrc file to ~/.zshrc.oh-my-zsh
  mv ~/.zshrc ~/.zshrc.oh-my-zsh
  if [ ! -e ~/.zshrc.pre-oh-my-zsh]
  then
    echo No prior ~/.zshrc file found
    echo source ~/zshrc.oh-my-zsh > ~/.zshrc
  else
    echo -e "source ~/.zshrc.oh-my-zsh\nsource ~/.zshrc.pre-oh-my-zsh > ~/.zshrc
  fi
  echo All set up!
fi

