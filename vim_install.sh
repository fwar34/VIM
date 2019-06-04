#!/bin/bash

lsb_release -d >/dev/null 2>&1
if [ $? -eq 0 ]; then
    #os=$(lsb_release -d|cut -d: -f2|sed 's/^[ \t]//')
    #os=$(lsb_release -i|awk '{print 3}')
    os=$(lsb_release -i|cut -f2)
else
    #os=$(MSYSTEM) #just define in msys
    os=$(uname -a|awk -F_ '{print $1}')
fi
echo $os

if [ ! -d ~/downloads ]; then
    mkdir -p ~/downloads
fi
if [ ! -d ~/mine ]; then
    mkdir -p ~/mine
fi

if [ ! -d ~/mine/VIM ]; then
    git clone https://github.com/fwar34/VIM.git ~/mine/VIM
fi

if [ ! -d ~/mine/vimfiles ]; then
    git clone https://github.com/fwar34/vimfiles.git ~/mine/vimfiles
fi

if [ ! -d ~/mine/nvim ]; then
    git clone https://github.com/fwar34/nvim.git ~/mine/nvim
fi

if [ ! -d ~/mine/Other ]; then
    git clone https://github.com/fwar34/Other.git ~/mine/Other
fi

if [ ! -d ~/.emacs.d ]; then
    git clone https://github.com/fwar34/emacs.d.git ~/.emacs.d
fi

if [ ! -d ~/.config ]; then
mkdir -p ~/.config
fi

if [ ! -d ~/.config/nvim ]; then
ln -s ~/mine/nvim ~/.config/nvim
fi

#if test "$os" = 'MSYS' -o "$os" = 'CYGWIN'
#if [ "$os" = 'MSYS' -o "$os" = 'CYGWIN' ]
#if [ "$os" = 'MSYS' ] || [ "$os" = 'CYGWIN' ]
if [ $os = 'Ubuntu' -o $os = 'Debian' ]; then
    sudo apt install curl wget build-essential zsh tmux autojump libncurses5-dev silversearcher-ag python3-pip cmake autoconf pkg-config
elif [ $os = 'ManjaroLinux' ]; then
    sudo pacman -S curl wget zsh tmux autojump ctags global fzf the_silver_searcher thefuck tig cmake 
fi

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

function install_my_bin()
{
    if [ ! -d ~/bin ]; then
        mkdir ~/bin
    fi
    #install diff-so-fancy
    if [ ! -f ~/bin/diff-so-fancy -a ! -f /usr/bin/diff-so-fancy ]; then
        wget "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" -O ~/bin/diff-so-fancy
        chmod +x ~/bin/diff-so-fancy
    fi

    if [ $os != 'ManjaroLinux' ]; then
        #install fd
        if [ ! -f /usr/bin/fd ]; then
            wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb -O ~/bin/fd_7.2.0_amd64.deb
            sudo dpkg -i ~/bin/fd_7.2.0_amd64.deb
            rm ~/bin/fd_7.2.0_amd64.deb
        fi
    fi

    #install tldr
    if [ ! -f ~/bin/tldr  -a ! -f /usr/bin/tldr ]; then
        curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
        chmod +x ~/bin/tldr
    fi

    if [  $os != 'ManjaroLinux' ]; then
        #install bat
        if [ ! -f /usr/bin/bat ]; then
            wget https://github.com/sharkdp/bat/releases/download/v0.8.0/bat_0.8.0_amd64.deb -O ~/bin/bat_0.8.0_amd64.deb
            sudo dpkg -i ~/bin/bat_0.8.0_amd64.deb
            rm ~/bin/bat_0.8.0_amd64.deb
        fi
    fi

    #install jq
    if [ ! -f ~/bin/jq -a ! -f /usr/bin/jq ]; then
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O ~/bin/jq
        chmod +x ~/bin/jq
    fi

    ln -s ~/mine/Other/v2ray/foxy.sh ~/bin/foxy.sh
}
install_my_bin

function bash_snippets()
{
    if [ ! -d ~/mine/Bash-Snippets ]; then
        git clone https://github.com/alexanderepstein/Bash-Snippets ~/mine/Bash-Snippets
        cd ~/mine/Bash-Snippets
        git checkout v1.22.0
        sudo ./install.sh all
    fi
}
#bash_snippets

if [ ! -d ~/downloads/ctags ]; then
    git clone https://github.com/universal-ctags/ctags --depth 1 ~/downloads/ctags
    cd ~/downloads/ctags
    ./autogen.sh
    ./configure
    make -j 4
    if [ $? -eq 0 ]; then
        sudo make install
    else
        echo "Compile universal-ctags failed!!!!"
        exit 1
    fi
fi

#proxychains https://github.com/rofl0r/proxychains-ng.git
#./configure --prefix=/usr --sysconfdir=/etc
#make
#[optional] sudo make install
#[optional] sudo make install-config (installs proxychains.conf)
if [ ! -d ~/downloads/proxychains-ng ]; then
    git clone https://github.com/rofl0r/proxychains-ng.git ~/downloads/proxychains-ng
    cd ~/downloads/proxychains-ng
    ./configure --prefix=/usr --sysconfdir=/etc
    make
    sudo make install
    sudo make install-config
fi

if [ ! -f ~/downloads/global-6.6.3.tar.gz ]; then
    wget http://tamacom.com/global/global-6.6.3.tar.gz -O ~/downloads/global-6.6.3.tar.gz
    cd ~/downloads/
    tar -zxvf global-6.6.3.tar.gz
    cd ~/downloads/global-6.6.3/ && ./configure --with-universal-ctags=/usr/local/bin/ctags && make -j 4
    if [ $? -eq 0 ]; then
        sudo make install
    else
        echo "Compile global failed!!!!"
        exit 1
    fi
fi

#if [ ! -f ~/downloads/ncdu-1.13.tar.gz ]
#then
#    wget https://dev.yorhel.nl/download/ncdu-1.13.tar.gz -O ~/downloads/ncdu-1.13.tar.gz
#    cd ~/downloads
#    tar -zxvf ncdu-1.13.tar.gz
#    cd ~/downloads/ncdu-1.13/ && ./configure && make -j 4 && sudo make install
#fi

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
ln -s ~/mine/vimfiles/vimrc ~/.vimrc

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

ln -sf ~/mine/vimfiles/_ideavimrc ~/.ideavimrc

#if [ -f ~/.gitconfig ]
#then
#mv ~/.gitconfig ~/.gitconfig.bak
#fi
#ln -s ~/mine/vimfiles/gitconfig ~/.gitconfig

#if [ -f ~/.globalrc ]
#then
#mv ~/.globalrc ~/.globalrc.bak
#fi
#ln -s ~/mine/vimfiles/globalrc ~/..globalrc

#if [ -f ~/.agignore ]
#then
#mv ~/.agignore ~/.agignore.bak
#fi
#ln -s ~/mine/VIM/agignore ~/.agignore

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

#build emacs-26 with x
#https://www.reddit.com/r/emacs/comments/7c0ry9/insall_emacs_27_from_source_ubuntu_1710_notes/
# sudo apt-get install build-essential automake texinfo libjpeg-dev libncurses5-dev
# sudo apt-get install libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev 
#./configure --with-mailutils

#build emacs-26 without x
# sudo apt install libgnutls28-dev
#./configure --without-x --with-mailutils


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

#pip3 install pygments
#pip3 install neovim pynvim clang

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
#compile emacs with x window
#sudo apt install libgtk-3-dev
#sudo apt-get install libxpm-dev libjpeg-dev libgif-dev libtiff5-dev libgnutls28-dev
