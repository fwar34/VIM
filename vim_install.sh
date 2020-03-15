#!/bin/bash

#lsb_release -d >/dev/null 2>&1
#if [[ $? -eq 0 ]]; then
#    #os=$(lsb_release -d|cut -d: -f2|sed 's/^[[ \t]]//')
#    #os=$(lsb_release -i|awk '{print 3}')
#    os=$(lsb_release -i|cut -f2)
#else
#    #os=$(MSYSTEM) #just define in msys
#    os=$(uname -a|awk -F_ '{print $1}')
#fi
#os=$(head -1 /etc/os-release|awk -F\" '{print $2}')
os=$(cat /etc/os-release|grep -E "\bID="|awk -F= '{print $2}')
echo ${os}

#if [[ ${os} = "ubuntu" ]] || [[ ${os} = "debian" ]] || [[ ${os} = "elementary" ]]; then
#	echo $os
#fi
#
#exit 1

if [[ ! -d ~/Downloads ]]; then
    mkdir -p ~/Downloads
fi
DOWNLOADS_NAME="Downloads"

if [[ ! -d ~/mine ]]; then
    mkdir -p ~/mine
fi

if [[ ! -d ~/mine/VIM ]]; then
    git clone https://github.com/fwar34/VIM.git ~/mine/VIM
fi

if [[ ! -d ~/mine/vimfiles ]]; then
    git clone https://github.com/fwar34/vimfiles.git ~/mine/vimfiles
fi

if [[ ! -d ~/mine/nvim ]]; then
    git clone https://github.com/fwar34/nvim.git ~/mine/nvim
fi

if [[ ! -d ~/mine/Other ]]; then
    git clone https://github.com/fwar34/Other.git ~/mine/Other
fi

if [[ ! -d ~/.emacs.d ]]; then
    git clone https://github.com/fwar34/emacs.d.git ~/.emacs.d
fi

if [[ ! -d ~/.config ]]; then
mkdir -p ~/.config
fi

if [[ ! -d ~/.config/nvim ]]; then
ln -s ~/mine/nvim ~/.config/nvim
fi

#if test "${os}" = 'MSYS' -o "${os}" = 'CYGWIN'
#if [[ "${os}" = 'MSYS' -o "${os}" = 'CYGWIN' ]]
#if [[ "${os}" = 'MSYS' ]] || [[ "${os}" = 'CYGWIN' ]]
if [[ ${os} == "ubuntu" ]] || [[ ${os} == "debian" ]] || [[ ${os} == "elementary" ]]; then
    VERSION_ID=$(cat /etc/os-release|grep VERSION_ID|awk -F= '{print $2}')
    if [[ ${VERSION_ID} == "14.04" ]] && [[ ${os} == "ubuntu" ]]; then
        git clone https://github.com/ggreer/the_silver_searcher ~/${DOWNLOADS_NAME}/ag
        if [[ $? -eq 0 ]]; then
            cd ~/${DOWNLOADS_NAME}/ag && ./build.sh && sudo make install
        else
            echo "install ag failed!"
        fi
    else
        sudo silversearcher-ag
    fi
    sudo apt install curl wget build-essential zsh tmux autojump libncurses5-dev \
         python3-pip cmake autoconf pkg-config
elif [[ ${os} == 'ManjaroLinux' ]] || [[ ${os} == 'arch' ]]; then
    sudo pacman -S curl wget zsh tmux autojump fzf the_silver_searcher \
	    thefuck tig cmake archlinuxcn/universal-ctags-git bat tldr python-pip
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

function install_my_bin()
{
    if [[ ! -d ~/bin ]]; then
        mkdir ~/bin
    fi

    DIFF_URL="https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy" 
    #install diff-so-fancy
    if [[ ! -f ~/bin/diff-so-fancy ]] && [[ ! -f /usr/bin/diff-so-fancy ]]; then
        wget ${DIFF_URL} -O ~/bin/diff-so-fancy && chmod +x ~/bin/diff-so-fancy
    fi

    if [[ ${os} != 'ManjaroLinux' ]] && [[ ${os} != 'arch' ]]; then
        #install fd
        if [[ ! -f /usr/bin/fd ]]; then
            wget https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb -O ~/bin/fd_7.2.0_amd64.deb
	    if [[ $? -eq 0 ]]; then
		    sudo dpkg -i ~/bin/fd_7.2.0_amd64.deb
		    rm ~/bin/fd_7.2.0_amd64.deb
	    else
		    echo "error: rm ~/bin/fd_7.2.0_amd64.deb"
	    fi
        fi
    fi

    #install tldr
    if [[ ! -f ~/bin/tldr ]] && [[ ! -f /usr/bin/tldr ]] && \
	    [[ ${os} != 'arch' ]] && [[ ${os} != 'ManjaroLinux' ]]; then
        curl -o ~/bin/tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
	if [[ $? -eq 0 ]]; then
		chmod +x ~/bin/tldr
	else
		echo "error: tldr did not exist"
	fi
    fi

    if [[  ${os} != 'ManjaroLinux' ]] && [[ ${os} != "arch" ]]; then
        #install bat
        if [[ ! -f /usr/bin/bat ]]; then
            wget https://github.com/sharkdp/bat/releases/download/v0.8.0/bat_0.8.0_amd64.deb \
		    -O ~/bin/bat_0.8.0_amd64.deb
		if [[ $? -eq 0 ]]; then
			sudo dpkg -i ~/bin/bat_0.8.0_amd64.deb
			rm ~/bin/bat_0.8.0_amd64.deb
		else
			echo "error: rm ~/bin/bat_0.8.0_amd64.deb"
		fi
        fi
    fi

    #install jq
    if [[ ! -f ~/bin/jq ]] && [[ ! -f /usr/bin/jq ]]; then
        wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O ~/bin/jq
	if [[ $? -eq 0 ]]; then
		chmod +x ~/bin/jq
	else
		echo "error: chmod +x ~/bin/jq"
	fi
    fi

    ln -sf ~/mine/Other/v2ray/foxy.sh ~/bin/foxy.sh

    #install manssh (or stormssh)
    #https://github.com/xwjdsh/manssh
    if [[ ! -f ~/bin/man ]]; then
        wget https://github.com/xwjdsh/manssh/releases/download/v0.5.1\
		/manssh_0.5.1_linux_amd64.tar.gz -O ~/${DOWNLOADS_NAME}/manssh.tar.gz
	if [[ $? -eq 0 ]]; then
		tar -zxvf ~/${DOWNLOADS_NAME}/manssh.tar.gz -C ~/bin/
	else
		echo "error: ar -zxvf ~/${DOWNLOADS_NAME}/manssh.tar.gz -C ~/bin/"
	fi
    fi
}
install_my_bin

function bash_snippets()
{
    if [[ ! -d ~/mine/Bash-Snippets ]]; then
        git clone https://github.com/alexanderepstein/Bash-Snippets ~/mine/Bash-Snippets
	if [[ $? -eq 0 ]]; then
		cd ~/mine/Bash-Snippets
		git checkout v1.22.0
		sudo ./install.sh all
	else
		echo "error: Bash-Snippets"
	fi
    fi
}
#bash_snippets

CTAGS_FLAG=$(ctags --version|grep Universal|wc -l)

if [[ ! -d ~/${DOWNLOADS_NAME}/ctags ]] && \
	[[ ${os} != 'arch' ]] && \
	[[ ${os} != 'ManjaroLinux' ]] && \
	[[ ${CTAGS_FLAG} -ne 2 ]]; then
    git clone https://github.com/universal-ctags/ctags --depth 1 ~/${DOWNLOADS_NAME}/ctags
    cd ~/${DOWNLOADS_NAME}/ctags
    ./autogen.sh
    ./configure
    make -j 4
    if [[ $? -eq 0 ]]; then
        sudo make install
    else
        echo "Compile universal-ctags failed!!!!"
        exit 1
    fi
fi

#proxychains https://github.com/rofl0r/proxychains-ng.git
#./configure --prefix=/usr --sysconfdir=/etc
#make
#[[optional]] sudo make install
#[[optional]] sudo make install-config (installs proxychains.conf)
if [[ ! -d ~/${DOWNLOADS_NAME}/proxychains-ng ]] && \
	[[ ! -f /usr/bin/proxychains4 ]] && \
	[[ ! -f /usr/local/bin/proxychains4 ]] && 
	[[ ${os} != 'arch' ]] && \
	[[ ${os} != 'ManjaroLinux' ]] && \
	[[ ! -f /usr/bin/ctags ]] && \
	[[ ${CTAGS_FLAG} -ne 2 ]]; then
    git clone https://github.com/rofl0r/proxychains-ng.git ~/${DOWNLOADS_NAME}/proxychains-ng
    cd ~/${DOWNLOADS_NAME}/proxychains-ng
    ./configure --prefix=/usr --sysconfdir=/etc
    make
    sudo make install
    sudo make install-config
fi

if [[ ! -f ~/${DOWNLOADS_NAME}/global-6.6.3.tar.gz ]] && \
	[[ -f /usr/local/bin/ctags ]] || [[ ${CTAGS_FLAG} -eq 2 ]]; then
    wget http://tamacom.com/global/global-6.6.3.tar.gz -O ~/${DOWNLOADS_NAME}/global-6.6.3.tar.gz
    cd ~/${DOWNLOADS_NAME}/
    tar -zxvf global-6.6.3.tar.gz
    if [[ -f /usr/local/bin/ctags ]]; then
        cd ~/${DOWNLOADS_NAME}/global-6.6.3/ && ./configure --with-universal-ctags=/usr/local/bin/ctags && make -j 4
    else
        cd ~/${DOWNLOADS_NAME}/global-6.6.3/ && ./configure --with-universal-ctags=/usr/bin/ctags && make -j 4
    fi
    if [[ $? -eq 0 ]]; then
        sudo make install
    else
        echo "Compile global failed!!!!"
        exit 1
    fi
fi

#if [[ ! -f ~/${DOWNLOADS_NAME}/ncdu-1.13.tar.gz ]]
#then
#    wget https://dev.yorhel.nl/download/ncdu-1.13.tar.gz -O ~/${DOWNLOADS_NAME}/ncdu-1.13.tar.gz
#    cd ~/${DOWNLOADS_NAME}
#    tar -zxvf ncdu-1.13.tar.gz
#    cd ~/${DOWNLOADS_NAME}/ncdu-1.13/ && ./configure && make -j 4 && sudo make install
#fi

if [[ -f ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.bak
fi
ln -sf ~/mine/vimfiles/vimrc ~/.vimrc

if [[ -f ~/.tmux.conf ]]
then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi
ln -s ~/mine/VIM/tmux.conf ~/.tmux.conf

if [[ -f ~/.zshrc ]]
then
    mv ~/.zshrc ~/.zshrc.bak
fi
ln -s ~/mine/VIM/zshrc.sh ~/.zshrc

# https://gist.github.com/redguardtoo/b12ddae3b8010a276e9b
if [[ -f ~/.ctags ]]
then
    mv ~/.ctags ~/.ctags.bak
fi
ln -s ~/mine/vimfiles/universal_ctags_config ~/.ctags

#if [[ -f ~/.config/TabNine/TabNine.toml ]]
#then
    #mv ~/.config/TabNine/TabNine.toml ~/.config/TabNine/TabNine.toml.bak
#fi
#ln -s ~/mine/vimfiles/TabNine/TabNine.toml.ccls ~/.config/TabNine/TabNine.toml

ln -sf ~/mine/vimfiles/_ideavimrc ~/.ideavimrc
ln -sf ~/mine/vimfiles/_vrapperrc ~/.vrapperrc

if [[ -f ~/.gitconfig ]]; then
mv ~/.gitconfig ~/.gitconfig.bak
fi
ln -s ~/mine/vimfiles/gitconfig ~/.gitconfig

#if [[ -f ~/.globalrc ]]
#then
#mv ~/.globalrc ~/.globalrc.bak
#fi
#ln -s ~/mine/vimfiles/globalrc ~/..globalrc

#if [[ -f ~/.agignore ]]
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
#sudo apt-get install build-essential automake texinfo libjpeg-dev libncurses5-dev \
#    libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
#./configure --with-mailutils --with-modules

#build emacs-26 without x
# sudo apt install libgnutls28-dev
#./configure --without-x --with-mailutils --with-modules


#common command
#A)thefuck Bash-Snippets(cheat cloudup crypt cryptocurrency currency geo lyrics meme movies newton 
#qrify short siteciphers stocks taste todo transfer weather youtube-viewer) jq ncdu htop bat tldr

#B)find grep awk sed tr xargs cat tail head less top cut nl

#v2ray bash <(curl -L -s https://install.direct/go.sh)
#proxychains https://github.com/rofl0r/proxychains-ng.git
#./configure --prefix=/usr --sysconfdir=/etc
#make
#[[optional]] sudo make install
#[[optional]] sudo make install-config (installs proxychains.conf)
#////////////////////////////////////////////////////////////////////
# http://goushi.me/navigation-in-vim/
#Replace Exuberant Ctags by Universal Ctags.
#git clone https://github.com/universal-ctags/ctags --depth 1
#cd ctags
#./autogen.sh
#./configure
#make
#sudo make install

#pip3 install neovim nvim pynvim clang jedi pygments

#Expand Universal Ctags by Gtags.

#wget http://tamacom.com/global/global-6.6.3.tar.gz
#tar xvf global-6.6.3.tar.gz
#cd global-6.6.3
#./configure --with-universal-ctags=/usr/local/bin/ctags
#make -j4
#sudo make install

#Generate tag files automatically by Gutentags.
#let g:gutentags_project_root = [['.root', '.svn', '.git', '.hg', '.project']]
#let g:gutentags_exclude_project_root = [[expand('~/.vim')]]
#let g:gutentags_cache_dir = expand('~/.cache/gutentags')

#let g:gutentags_modules = [[]]
#if executable('ctags')
#let g:gutentags_modules += [['ctags']]
#endif
#if executable('gtags-cscope') && executable('gtags')
#let g:gutentags_modules += [['gtags_cscope']]
#endif

#" Universal Ctags support Wildcard in options.
#let g:gutentags_ctags_extra_args = [['--fields=*', '--extras=*', '--all-kinds=*']]
#let g:gutentags_ctags_extra_args += [['--output-format=e-ctags']]

#" If built-in parser exists for the target, it is used.
#" Else if pygments parser exists it is used.
#let $GTAGSLABEL = 'native-pygments'
#let $GTAGSCONF = expand('~/.vim/globalrc')
#////////////////////////////////////////////////////////////////////
#compile emacs with x window
#sudo apt install libgtk-3-dev
#sudo apt-get install libxpm-dev libjpeg-dev libgif-dev libtiff5-dev libgnutls28-dev

#////////////////////////////////////////////////////////////////////
#https://www.jianshu.com/p/ea651cdc5530
#pacman
#删除无用的包pacman -Rns $(pacman -Qdtq)
#安装包

#➔ pacman -S 包名：例如，执行 pacman -S firefox 将安装 Firefox。你也可以同时安装多个包，
#只需以空格分隔包名即可。
#➔ pacman -Sy 包名：与上面命令不同的是，该命令将在同步包数据库后再执行安装。
#➔ pacman -Sv 包名：在显示一些操作信息后执行安装。
#➔ pacman -U：安装本地包，其扩展名为 pkg.tar.gz。
#➔ pacman -U http://www.example.com/repo/example.pkg.tar.xz 安装一个远程包（不在 pacman 配置的源里面）
#删除包

#➔ pacman -R 包名：该命令将只删除包，保留其全部已经安装的依赖关系
#➔ pacman -Rs 包名：在删除包的同时，删除其所有没有被其他已安装软件包使用的依赖关系
#➔ pacman -Rsc 包名：在删除包的同时，删除所有依赖这个软件包的程序
#➔ pacman -Rd 包名：在删除包时不检查依赖。
#搜索包

#➔ pacman -Ss 关键字：在仓库中搜索含关键字的包。
#➔ pacman -Qs 关键字： 搜索已安装的包。
#➔ pacman -Qi 包名：查看有关包的详尽信息。
#➔ pacman -Ql 包名：列出该包的文件。
#其他用法

#➔ pacman -Sw 包名：只下载包，不安装。
#➔ pacman -Sc：清理未安装的包文件，包文件位于 /var/cache/pacman/pkg/ 目录。
#➔ pacman -Scc：清理所有的缓存文件
#////////////////////////////////////////////////////////////////////
# wsl 字体设置
# 中文字体安装及中文配置
# 安装字体管理包
# sudo apt-get install --assume-yes fontconfig
# 安装中文字体
# sudo mkdir -p /usr/share/fonts/windows && sudo cp -r /c/Windows/Fonts/*.ttf /usr/share/fonts/windows/
# 清除字体缓存
# fc-cache
# 生成中文环境
# sudo locale-gen zh_CN.UTF-8
