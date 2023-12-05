#!/bin/bash

# Script to install colorls (https://github.com/athityakumar/colorls)

# Install ruby
sudo apt-get install -y ruby-full


# Install colorls
sudo gem install colorls

# Add alias to .zshrc
echo "
# colorls alias
alias ls=\"colorls\"
" >> ~/.zshrc


# Warn user to install Hack Nerd Font
echo -e "\e[33mWARNING: \e[33mYou need to install Hack Nerd Font, https://www.nerdfonts.com/font-downloads, then set your terminal font to Hack Nerd Font.\e[39m"