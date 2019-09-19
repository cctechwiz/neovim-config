pushd $HOME/bin >> /dev/null

# Download latest stable release
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ./nvim.appimage

echo 'Current version:'
./nvim.appimage --version | head -n 1

popd >> /dev/null

