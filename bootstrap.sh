#!/usr/bin/env bash

if [[ ! -z $(which yum) ]]; then
    pkgmanager="sudo yum install -y "
else
    pkgmanager="sudo apt-get install -y "
fi

installs="zsh git gcc-c++ cmake"

eval $pkgmanager$installs

chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -s $PWD/dotfiles/.vimrc ~/.vimrc
ln -s $PWD/dotfiles/.tmux.conf ~/.tmux.conf
ln -s $PWD/dotfiles/.zshrc ~/.zshrc
ln -s $PWD/dotfiles/.gitconfig ~/.gitconfig
