#!/bin/bash

# --- Color Definitions ---
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Starting dotfiles installation...${NC}"

# --- Detect Operating System ---
OS_NAME=$(uname -s)
if [[ "$OS_NAME" == "Darwin" ]]; then
    echo -e "${GREEN}Detected macOS${NC}"
    # Install Homebrew if not present
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # Install tools
    brew install git curl zsh
elif [[ "$OS_NAME" == "Linux" ]]; then
    if [ -f /etc/lsb-release ] || [ -f /etc/debian_version ]; then
        echo -e "${GREEN}Detected Ubuntu/Debian${NC}"
        sudo apt update
        sudo apt install -y git curl zsh build-essential
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
else
    echo "Unsupported Operating System: $OS_NAME"
    exit 1
fi

# --- Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Install Oh My Zsh Plugins ---
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
echo -e "${BLUE}Installing plugins...${NC}"

# Syntax highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Auto-suggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# --- Clone Dotfiles if not present ---
DOTFILES_DIR="$HOME/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${BLUE}Cloning dotfiles...${NC}"
    git clone https://github.com/YOUR_USERNAME/dotfiles.git "$DOTFILES_DIR"
fi

# --- Configure Zsh ---
echo -e "${BLUE}Configuring Zsh...${NC}"

# Backup existing .zshrc
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "Backing up existing .zshrc to .zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Symlink .zshrc
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Create .zshrclocal if it doesn't exist
if [ ! -f "$HOME/.zshrclocal" ]; then
    cp "$DOTFILES_DIR/zsh/zshrclocal.example" "$HOME/.zshrclocal"
    echo "Created ~/.zshrclocal from template."
fi

# --- Final Steps ---
echo -e "${GREEN}Installation complete!${NC}"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."

# Change shell to zsh if it's not already
if [[ "$SHELL" != *zsh ]]; then
    echo "Changing your default shell to Zsh..."
    chsh -s "$(which zsh)"
fi
