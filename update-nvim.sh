pushd ~/bin

# Download latest stable release
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ./nvim.appimage

# Update system alternatives to use neovim
# sudo update-alternatives --install /usr/bin/vi vi /home/jmaxwel/bin/nvim.appimage 60
# sudo update-alternatives --install /usr/bin/vim vim /home/jmaxwel/bin/nvim.appimage 60
# sudo update-alternatives --install /usr/bin/editor editor /home/jmaxwel/bin/nvim.appimage 60

popd

