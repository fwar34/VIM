#########################################################################
# File Name: cp.sh
# Author: Feng
# Created Time: Thu 09 Nov 2017 01:03:28 PM CST
# Content: ./cp.sh (push|pull) 必须在VIM目录执行
#		  拷贝vim的配置到VIM目录，或者从VIM目录拷贝vim配置文件到用户目录
#########################################################################
#!/bin/bash

push()
{
	cp ~/.vimrc ./vimrc
	cp ~/.vim/syntax/c.vim ./syntax/
	cp ~/.vim/syntax/cpp.vim ./syntax/
	cp ~/.vim/colors/wombat256.vim ./colors/
	cp ~/.vim/colors/codeschool.vim ./colors/
    if [ -f "~/.gitconfig" ]
    then
        cp ~/.gitconfig ./git/gitconfig
    fi
}

pull()
{
	cp ./vimrc ~/.vimrc

	if [ -d "~/.vim" ]
	then
		if [ ! -d "~/.vim/syntax" ]
		then
			mkdir -p ~/.vim/syntax
		fi

		if [ ! -d "~/.vim/colors" ]
		then
			mkdir -p ~/.vim/colors
		fi
	else
		mkdir -p ~/.vim/syntax
		mkdir -p ~/.vim/colors
	fi

	cp ./syntax/c.vim ~/.vim/syntax/
	cp ./syntax/cpp.vim ~/.vim/syntax/
	cp ./colors/wombat256.vim ~/.vim/colors/
	cp ./colors/codeschool.vim ~/.vim/colors/
    if [ -f "~/.gitconfig" ]
    then
        cp ~/.gitconfig ~/.gitconfig.bak
    fi
    cp ./git/gitconfig ~/.gitconfig
}

if [ $# -eq 0 ]
#if [ -z $1 ]
then
	echo "use ./cp.sh (push|pull)"
	exit
fi

if [ $1 == "push" ]
then
	push
elif [ $1 == "pull" ]
then
	pull
else
	echo "use ./cp.sh (push|pull)"
fi
