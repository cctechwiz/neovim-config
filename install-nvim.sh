echo 'Setting up directories'
mkdir -p ~/.config/nvim
mkdir -p ~/bin/

echo 'Installing dependencies'
sudo apt update
sudo apt install curl xclip python3-pip
pip3 install pynvim

pushd ~/bin
echo 'Downloading latest stable neovim'
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ./nvim.appimage
popd

echo 'Updating system alternatives to use neovim'
sudo update-alternatives --install /usr/bin/vi vi /home/jmaxwel/bin/nvim.appimage 60
sudo update-alternatives --install /usr/bin/vim vim /home/jmaxwel/bin/nvim.appimage 60
sudo update-alternatives --install /usr/bin/editor editor /home/jmaxwel/bin/nvim.appimage 60

echo 'Installing vim-plug'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
