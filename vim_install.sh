#!/bin/bash

os=$(uname -a|awk -F_ '{print $1}')

if test $os = 'MSYS' -o $os = 'CYGWIN'
then
    if [ ! -d ~/vimfiles ]
    then
        mkdir -p ~/vimfiles/autoload/
        cd ~/vimfiles/autoload/
        wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        if [ ! -f ~\vimfiles\autoload\plug.vim ]
        then
            wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
    fi
else
    if [ ! -f ~/.vim/autoload/plug.vim ]
    then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
fi

if [ ! -d ~/.oh-my-zsh ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -f ~\downloads\global-6.6.2.tar.gz ]
then
    cd ~\downloads
    wget http://tamacom.com/global/global-6.6.2.tar.gz
fi

if [ -f ~/.vimrc ]
then
	mv ~/.vimrc ~/.vimrc.bak
fi
ln -s ~/mine/VIM/vimrc.vim-plug ~/.vimrc

if test $os = 'MSYS' -o $os = 'CYGWIN'
then
    if [ -f ~/_vimrc ]
    then
        mv ~/_vimrc ~/_vimrc.bak
    fi
    cp ~/mine/VIM/vimrc.vim-plug ~/_vimrc
fi

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
