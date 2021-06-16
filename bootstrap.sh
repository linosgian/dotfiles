#!/usr/bin/env bash

sudo apt install zsh git xclip gcc make ripgrep

chsh -s $(which zsh)
# Avoid running into zsh during bootstraping
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions

mkdir -p ~/.vim/after/plugin
ln -s $PWD/dotfiles/after/hifix.vim ~/.vim/after/plugin
ln -s $PWD/dotfiles/.vimrc ~/.vimrc

# Install all vim plugins
vim +PlugInstall +qall

# Oh-my-zsh creates a sample .zshrc already, so remove it.
rm ~/.zshrc
touch ~/.zshrc_local
mkdir -p $HOME/.config/systemd/user
ln -s $PWD/dotfiles/.zshrc ~/.zshrc
ln -s $PWD/dotfiles/.gitconfig ~/.gitconfig
ln -s $PWD/dotfiles/honukai.zsh-theme $HOME/.oh-my-zsh/themes/
ln -s $PWD/dotfiles/kitty $HOME/.config/kitty
ln -s $PWD/dotfiles/gtk-3.0 $HOME/.config/
ln -s $PWD/dotfiles/dunst $HOME/.config/
ln -s $PWD/dotfiles/rofi $HOME/.config/
ln -s $PWD/dotfiles/.compton.conf $HOME/
ln -s $PWD/dotfiles/.Xresources $HOME/
ln -s $PWD/dotfiles/.xinitrc $HOME/
ln -s $PWD/dotfiles/i3 $HOME/.config
ln -s $PWD/dotfiles/polybar $HOME/.config
ln -s $PWD/dotfiles/systemd/ssh-agent.service $HOME/.config/systemd/user/
ln -s $PWD/dotfiles/systemd/ssh-agent.service $HOME/.config/systemd/user/
