# Dotfiles for Ubuntu and macOS

A cross-platform dotfiles repository designed for quick setup on a new system.

## Features
-   Supports **macOS** (using Homebrew) and **Ubuntu** (using apt).
-   Automated installation of `zsh`, `vim`, `oh-my-zsh`, and essential plugins.
-   Modular configuration with `zshrclocal` for sensitive information.
-   One-line installation command.

## Quick Start (Installation)

On a brand-new system, you can fetch and run the installation script:

```bash
# Clone and Install
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Alternatively, you can run it directly:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/dotfiles/main/install.sh)"
```

*Note: Replace `YOUR_USERNAME` with your actual GitHub username.*

## Structure
-   `install.sh`: The main installation and setup script.
-   `zsh/zshrc`: The main Zsh configuration file (symlinked to `~/.zshrc`).
-   `zsh/zshrclocal`: (Optional) Local/sensitive configurations (ignored by git).
-   `zsh/zshrclocal.example`: Example for the local configuration file.
-   `vim/vimrc`: The main Vim configuration file (symlinked to `~/.vimrc`).

## Vim Support
-   Automatically installs Vim and links `vim/vimrc` to `~/.vimrc` at install time.
-   Includes basic configurations:
    - `syntax on`
    - `filetype plugin indent on`
    - command line completion with `set wildmenu`
    - absolute and relative line numbering
    - shell script file type detection
-   Add more Vim customizations in `vim/vimrc` and commit to this repo for cross-device sync.

## Post-Installation
After installation, you can add your sensitive data (like API keys) to `~/.zshrclocal`.

## Customization
Modify `zsh/zshrc` for global aliases and themes. These changes can be committed and pushed to your GitHub repository.

```bash
cd ~/dotfiles
git add .
git commit -m "Update zsh config"
git push origin main
```
