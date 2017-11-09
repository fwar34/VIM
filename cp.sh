#########################################################################
# File Name: cp.sh
# Author: Feng
# Created Time: Thu 09 Nov 2017 01:03:28 PM CST
# Content: 
#########################################################################
#!/bin/bash

push()
{
	cp ~/.vimrc ./vimrc
	cp ~/.vim/syntax/c.vim ./syntax/
	cp ~/.vim/syntax/cpp.vim ./syntax/
	cp ~/.vim/colors/wombat256.vim ./colors/
	cp ~/.vim/colors/codeschool.vim ./colors/
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
}

if [ $1 == "push" ]
then
	push
else
	pull
fi
