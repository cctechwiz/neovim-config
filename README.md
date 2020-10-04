# Neovim Configuration

### Installing Nvim on Unix Systems
```bash
# Clone Config
git clone git@github.com:cctechwiz/neovim-config.git ~/.config/nvim

# Run Install Script (Install Neovim from GitHub:stable version)
cd ~/.config/nvim
bash ./install.sh
```

### Installing Nvim on Windows
```bash
# Install Neovim
choco install neovim

# Clone Config
git clone git@github.com:cctechwiz/neovim-config.git ~/AppData/Local/nvim

# Install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim" -Force

# Install Neovim Plugins
nvim +PlugInstall +qall
```
