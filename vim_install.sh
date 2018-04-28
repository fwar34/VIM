#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
wget http://tamacom.com/global/global-6.6.2.tar.gz
ln -s ~/mine/VIM/vimrc.vim-plug ~/.vimrc
ln -s ~/mine/VIM/tmux.conf ~/.tmux.conf
ln -s ~/mine/VIM/zshrc ~/.zshrc
ln -s ~/mine/VIM/git/gitconfig ~/.gitconfig
