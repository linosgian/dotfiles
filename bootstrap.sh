#!/usr/bin/env bash

function install_tmux_2_5(){
	VERSION=2.5
	sudo apt-get -y remove tmux
	sudo apt-get -y install wget tar libevent-dev libncurses-dev
	wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
	tar xf tmux-${VERSION}.tar.gz
	rm -f tmux-${VERSION}.tar.gz
	cd tmux-${VERSION}
	./configure
	make
	sudo make install
	cd -
	sudo rm -rf /usr/local/src/tmux-*
	sudo mv tmux-${VERSION} /usr/local/src
}

#if [[ -z $(which rg) ]]; then
#   echo "Please install ripgrep from https://github.com/BurntSushi/ripgrep then come back"
#   exit
#fi
if [[ ! -z $(which yum) ]]; then
    pkgmanager="sudo yum install -y "
else
    pkgmanager="sudo apt-get install -y "
fi

installs="zsh git xclip gcc make"

# CHECK IF TMUX is > 2.5
which "tmux" || install_tmux_2_5
eval $pkgmanager$installs

chsh -s $(which zsh)
# Avoid running into zsh during bootstraping
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"
sh -c "$(curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)"
git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k
git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# This will install all tmux plugins
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

mkdir -p ~/.vim/after/plugin
ln -s $PWD/dotfiles/after/hifix.vim ~/.vim/after/plugin
ln -s $PWD/dotfiles/.vimrc ~/.vimrc
ln -s $PWD/dotfiles/.tmux.conf ~/.tmux.conf

# Install all vim plugins
vim +PlugInstall +qall

# Oh-my-zsh creates a sample .zshrc already, so remove it.
rm ~/.zshrc
touch ~/.zshrc_local
ln -s $PWD/dotfiles/.zshrc ~/.zshrc
ln -s $PWD/dotfiles/.gitconfig ~/.gitconfig
ln -s $PWD/dotfiles/honukai.zsh-theme $HOME/.oh-my-zsh/themes/
ln -s $PWD/dotfiles/kitty $HOME/.config/kitty
