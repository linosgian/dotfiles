#!/usr/bin/env bash

sudo apt install zsh git xclip gcc make ripgrep python3-xlib xss-lock rofi zsh-autosuggestions zsh-syntax-highlighting polybar
chsh -s $(which zsh)
# Avoid running into zsh during bootstraping
sh -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"

mkdir -p ~/.vim/after/plugin
ln -s $PWD/dotfiles/after/hifix.vim ~/.vim/after/plugin
ln -s $PWD/dotfiles/.vimrc ~/.vimrc

# Install all vim plugins
vim +PlugInstall +qall

touch ~/.zshrc_local
ln -s $PWD/dotfiles/.zshrc ~/.zshrc
ln -s $PWD/dotfiles/.gitconfig ~/.gitconfig
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
ln -s $PWD/dotfiles/systemd/xss-dimmer@.service $HOME/.config/systemd/user/
ln -s $PWD/dotfiles/systemd/xss-lock.service $HOME/.config/systemd/user/
