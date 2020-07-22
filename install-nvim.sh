echo 'Setting up directories'
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/bin/

echo 'Installing dependencies'
sudo apt update
sudo apt install fuse curl xclip python-pip python3-pip
pip install pynvim
pip3 install pynvim

pushd $HOME/bin
echo 'Downloading latest stable neovim'
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ./nvim.appimage
popd

echo 'Updating system alternatives to use neovim'
sudo update-alternatives --install /usr/bin/vi vi $HOME/bin/nvim.appimage 60
sudo update-alternatives --install /usr/bin/vim vim $HOME/bin/nvim.appimage 60
sudo update-alternatives --install /usr/bin/editor editor $HOME/bin/nvim.appimage 60

echo 'Adding nvim alias (reload required)'
echo "alias nvim='vim'" >> ~/.bash_aliases

echo 'Installing vim-plug'
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Installing / Updating plugins from init.nvim'
~/bin/nvim.appimage -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall'

echo 'Checking the health of current nvim configuration'
~/bin/nvim.appimage -c ':checkhealth'

echo 'Done! Enjoy Neovim!'
exit 0
