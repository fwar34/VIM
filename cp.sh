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
    cp ~/.vim/doc/taglist.txt ./doc/
    cp ~/.vim/plugin/taglist.vim ./plugin/
    cp ~/.vim/after/ftplugin/* ./after/ftplugin/
    if [ -f ~/.gitconfig ]
    then
        cp ~/.gitconfig ./git/gitconfig
    fi
}

pull()
{
	cp ./vimrc ~/.vimrc

	if [ -d ~/.vim ]
	then
		if [ ! -d ~/.vim/syntax ]
		then
			mkdir -p ~/.vim/syntax
		fi

		if [ ! -d ~/.vim/colors ]
		then
			mkdir -p ~/.vim/colors
		fi

		if [ ! -d ~/.vim/doc ]
		then
			mkdir -p ~/.vim/doc
		fi

		if [ ! -d ~/.vim/plugin ]
		then
			mkdir -p ~/.vim/plugin
		fi

        if [ ! -d ~/.vim/after/ftplugin ]
        then
            mkdir -p ~/.vim/after/ftplugin
        fi

        if [ ! -d ~/.vim/autoload/omni/cpp ]
        then
            mkdir -p ~/.vim/autoload/omni/cpp
        fi

        if [ ! -d ~/.vim/autoload/omni/common ]
        then
            mkdir -p ~/.vim/autoload/omni/common
        fi
	else
		mkdir -p ~/.vim/syntax
		mkdir -p ~/.vim/colors
        mkdir -p ~/.vim/doc
        mkdir -p ~/.vim/plugin
        mkdir -p ~/.vim/after/ftplugin
        mkdir -p ~/.vim/autoload/omni/common
        mkdir -p ~/.vim/autoload/omni/cpp
	fi

	cp ./syntax/c.vim ~/.vim/syntax/
	cp ./syntax/cpp.vim ~/.vim/syntax/
	cp ./colors/wombat256.vim ~/.vim/colors/
	cp ./colors/codeschool.vim ~/.vim/colors/
    cp ./doc/taglist.txt ~/.vim/doc/
    cp ./doc/omnicppcomplete.txt ~/.vim/doc/
    cp ./plugin/taglist.vim ~/.vim/plugin/
    cp ./after/ftplugin/* ~/.vim/after/ftplugin/
    cp ./autoload/omni/common/* ~/.vim/autoload/omni/common/
    cp ./autoload/omni/cpp/* ~/.vim/autoload/omni/cpp/
    cp ./plugin/a.vim ~/.vim/plugin/
    cp ./autoload/a.vim ~/.vim/autoload/
    cp ./doc/alternate.txt ~/.vim/doc/
    if [ -f ~/.gitconfig ]
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
