#!/bin/bash

# Script to install zsh, oh-my-zsh and setup plugins (including powerlevel10k)

file=~/.zshrc

# Install zsh
sudo apt-get install -y zsh

# Set zsh as default shell
sudo chsh -s $(which zsh)

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Enable zshconfig alias
if grep -q '# alias zshconfig="mate ~/.zshrc"' "$file"; then
    sed -i 's|# alias zshconfig="mate ~/.zshrc"|alias zshconfig="vim ~/.zshrc"|' ~/.zshrc
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Install zsh-autosuggestions plugin
AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [ ! -d "$AUTOSUGGESTIONS_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin
SYNTAX_HIGHLIGHTING_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_HIGHLIGHTING_DIR" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Configure docker plugin
content="
# Docker plugin options stacking
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
"

if ! grep -qF "$content" "$file"; then
    echo "$content" >> "$file"
fi

# Update zsh plugins
if grep -q '^plugins=(git)' "$file"; then
    sed -i '/^plugins=(git)/c\
plugins=(\
    git \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    docker \
)' "$file"
fi

# Install powerlevel10k
POWERLEVEL10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ ! -d "$POWERLEVEL10K_DIR" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Set powerlevel10k as default theme
if grep -q '^ZSH_THEME="robbyrussell"' "$file"; then
    sed -i 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
fi

# Restart zsh
zsh

# Run p10k configure
p10k configure
