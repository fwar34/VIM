#!/bin/bash

lsb_release -d >/dev/null 2>&1
if [ $? -eq 0 ]
then
    #os=$(lsb_release -d|cut -d: -f2|sed 's/^[ \t]//')
    #os=$(lsb_release -i|awk '{print 3}')
    os=$(lsb_release -i|cut -f2)
else
    #os=$(MSYSTEM) #just define in msys
    os=$(uname -a|awk -F_ '{print $1}')
fi
echo $os

#if test "$os" = 'MSYS' -o "$os" = 'CYGWIN'
#if [ "$os" = 'MSYS' -o "$os" = 'CYGWIN' ]
if [ "$os" = 'MSYS' ] || [ "$os" = 'CYGWIN' ]
then
    if [ ! -d ~/vimfiles ]
    then
        mkdir -p ~/vimfiles/autoload/
        wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/vimfiles/autoload/plug.vim
    else
        if [ ! -f ~/vimfiles/autoload/plug.vim ]
        then
            wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/vimfiles/autoload/plug.vim
        fi
    fi
else
    if [ $os = 'Ubuntu' -o $os = 'Debian' ]
    then
        sudo apt install curl wget build-essential zsh tmux autojump ctags libncurses5-dev ctags silversearcher-ag python-pip python3-pip cmake
    elif [ $os = 'ManjaroLinux' ]
    then
        sudo pacman -S curl wget zsh tmux autojump ctags global fzf the_silver_searcher thefuck tig cmake
    fi

    if [ ! -f ~/.vim/autoload/plug.vim ]
    then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    #if [ ! -f ~/.config/nvim/autoload/plug.vim ]
    #then
        #curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
                #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    #fi
fi

if [ ! -d ~/.oh-my-zsh ]
then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

function install_my_bin()
{
    if [ ! -d ~/bin ]
    then
        mkdir ~/bin
    fi
    #install diff-so-fancy
    if [ ! -f ~/bin/diff-so-fancy -a ! -f /usr/bin/diff-so-fancy ]
    then
        wget "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" \
            -O ~/bin/diff-so-fancy
                    chmod +x ~/bin/diff-so-fancy
                fi

                if [ $os != 'ManjaroLinux' ]
                then
                    #install fd
                    if [ ! -f /usr/bin/fd ]
                    then
                        wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb -O ~/bin/fd_7.2.0_amd64.deb
                        sudo dpkg -i ~/bin/fd_7.2.0_amd64.deb
                        rm ~/bin/fd_7.2.0_amd64.deb
                    fi
                fi

    #install tldr
    if [ ! -f ~/bin/tldr  -a ! -f /usr/bin/tldr ]
    then
        curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
        chmod +x ~/bin/tldr
    fi

    if [  $os != 'ManjaroLinux' ]
    then
        #install bat
        if [ ! -f /usr/bin/bat ]
        then
            wget https://github.com/sharkdp/bat/releases/download/v0.8.0/bat_0.8.0_amd64.deb -O ~/bin/bat_0.8.0_amd64.deb
            sudo dpkg -i ~/bin/bat_0.8.0_amd64.deb
            rm ~/bin/bat_0.8.0_amd64.deb
        fi
    fi

    #install jq
    if [ ! -f ~/bin/jq -a ! -f /usr/bin/jq ]
    then
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O ~/bin/jq
        chmod +x ~/bin/jq
    fi

    ln -s ~/mine/Other/v2ray/foxy.sh ~/bin/foxy.sh
}
install_my_bin

function bash_snippets()
{
    if [ ! -d ~/mine/Bash-Snippets ]
    then
        cd ~/mine
        git clone https://github.com/alexanderepstein/Bash-Snippets
        cd Bash-Snippets
        git checkout v1.22.0
        sudo ./install.sh all
    fi
}
#bash_snippets

if [ ! -f ~/downloads/global-6.6.2.tar.gz ]
then
    wget http://tamacom.com/global/global-6.6.2.tar.gz -O ~/downloads/global-6.6.2.tar.gz
    cd ~/downloads/
    tar -zxvf global-6.6.2.tar.gz
    cd ~/downloads/global-6.6.2/ && ./configure && make -j 4 && sudo make install
fi

#if [ ! -f ~/downloads/ncdu-1.13.tar.gz ]
#then
#    wget https://dev.yorhel.nl/download/ncdu-1.13.tar.gz -O ~/downloads/ncdu-1.13.tar.gz
#    cd ~/downloads
#    tar -zxvf ncdu-1.13.tar.gz
#    cd ~/downloads/ncdu-1.13/ && ./configure && make -j 4 && sudo make install
#fi

if [ -f ~/.vimrc ]
then
	mv ~/.vimrc ~/.vimrc.bak
fi
#ln -s ~/mine/VIM/vimrc.vim-plug ~/.vimrc
ln -s ~/mine/vimfiles/vimrc ~/.vimrc


#if [ ! -d ~/.config/nvim ]
#then
    #mkdir -p ~/.config/nvim
#fi

#if [ -f ~/.config/nvim/init.vim ]
#then
	#mv ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak
#fi
#ln -s ~/mine/VIM/vimrc.vim-plug ~/.config/nvim/init.vim

if test "$os" = 'MSYS' -o "$os" = 'CYGWIN'
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
ln -s ~/mine/vimfiles/gitconfig ~/.gitconfig

if [ -f ~/.globalrc ]
then
	mv ~/.globalrc ~/.globalrc.bak
fi
ln -s ~/mine/vimfiles/globalrc ~/..globalrc

if [ -f ~/.agignore ]
then
	mv ~/.agignore ~/.agignore.bak
fi
ln -s ~/mine/VIM/agignore ~/.agignore

if [ ! -d ~/.vim/ ]
then
    echo "~/.vim is not exist!!!!!!!!"
else
    if [ ! -d ~/.config ]; then
        mkdir -p ~/.config
    fi

    if [ ! -d ~/.config/nvim ]
    then
        ln -s ~/mine/nvim ~/.config/nvim
    fi
fi

echo Complete

#sudo apt install build-essential cmake git zsh tmux autojump ctags clang python3-pip python-pip silversearcher-ag

#support python2
#--enable-pythoninterp=yes \
#--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \

#build vim
# https://github.com/vim/vim.git
#./configure --with-features=huge \
    #--enable-multibyte \
    #--enable-rubyinterp=yes \
    #--enable-python3interp=yes \
    #--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
    #--enable-perlinterp=yes \
    #--enable-luainterp=yes \
    #--enable-cscope

#build emacs-26
#./configure --without-x --with-gnutls=no --with-mailutils

#common command
#A)thefuck Bash-Snippets(cheat cloudup crypt cryptocurrency currency geo lyrics meme movies newton 
#qrify short siteciphers stocks taste todo transfer weather youtube-viewer) jq ncdu htop bat tldr

#B)find grep awk sed tr xargs cat tail head less top cut nl

#v2ray bash <(curl -L -s https://install.direct/go.sh)
#proxychains https://github.com/rofl0r/proxychains-ng.git
#./configure --prefix=/usr --sysconfdir=/etc
#make
#[optional] sudo make install
#[optional] sudo make install-config (installs proxychains.conf)
#////////////////////////////////////////////////////////////////////
# http://goushi.me/navigation-in-vim/
#Replace Exuberant Ctags by Universal Ctags.
#git clone https://github.com/universal-ctags/ctags --depth 1
#cd ctags
#./autogen.sh
#./configure
#make
#sudo make install

#pip install pygments

#Expand Universal Ctags by Gtags.
    
#wget http://tamacom.com/global/global-6.6.3.tar.gz
#tar xvf global-6.6.3.tar.gz
#cd global-6.6.3
#./configure --with-universal-ctags=/usr/local/bin/ctags
#make -j4
#sudo make install

#Generate tag files automatically by Gutentags.
#let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
#let g:gutentags_exclude_project_root = [expand('~/.vim')]
#let g:gutentags_cache_dir = expand('~/.cache/gutentags')
 
#let g:gutentags_modules = []
#if executable('ctags')
	#let g:gutentags_modules += ['ctags']
#endif
#if executable('gtags-cscope') && executable('gtags')
	#let g:gutentags_modules += ['gtags_cscope']
#endif
 
#" Universal Ctags support Wildcard in options.
#let g:gutentags_ctags_extra_args = ['--fields=*', '--extras=*', '--all-kinds=*']
#let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
 
#" If built-in parser exists for the target, it is used.
#" Else if pygments parser exists it is used.
#let $GTAGSLABEL = 'native-pygments'
#let $GTAGSCONF = expand('~/.vim/globalrc')
#////////////////////////////////////////////////////////////////////
