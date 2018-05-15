#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

if [ ! -f global-6.6.2.tar.gz ]
then
	wget http://tamacom.com/global/global-6.6.2.tar.gz
fi

if [ -f ~/.vimrc ]
then
	mv ~/.vimrc ~/.vimrc.bak
fi
ln -s ~/mine/VIM/vimrc.vim-plug ~/.vimrc

if [ -f ~/.tmux.conf ]
then
	mv ~/.tmux.conf ~/.tmux.conf.bak
fi
ln -s ~/mine/VIM/tmux.conf ~/.tmux.conf

if [ -f ~/.zshrc ]
then
	mv ~/.zshrc ~/.zshrc.bak
fi
ln -s ~/mine/VIM/zshrc ~/.zshrc

if [ -f ~/.gitconfig ]
then
	mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -s ~/mine/VIM/git/gitconfig ~/.gitconfig
