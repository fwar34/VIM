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

if [[ ! -d ~/mine/nvim.lua ]]; then
    git clone https://github.com/fwar34/nvim.lua.git ~/mine/nvim.lua
fi

#if [[ ! -d ~/mine/Other ]]; then
#    git clone https://github.com/fwar34/Other.git ~/mine/Other
#fi

if [[ ! -d ~/bin ]]; then
    mkdir -p ~/bin
fi
ln -sf ~/mine/VIM/screenshot ~/bin/screenshot

if [[ ! -d ~/mine/Python ]]; then
    git clone https://github.com/fwar34/Python.git ~/mine/Python
fi
ln -sf ~/mine/Python/parse_binary.py ~/bin/pb

if [[ ! -d ~/.emacs.d ]]; then
    git clone https://github.com/fwar34/emacs.d.git ~/.emacs.d
    cd ~/.emacs.d/
    git submodule update --init --recursive
fi

if [[ ! -d ~/.config ]]; then
    mkdir -p ~/.config
fi

if [[ -d ~/.config/nvim ]]
then
    mv ~/.config/nvim ~/.config/nvim.bak
fi

if [[ ! -d ~/.config/nvim ]]; then
    ln -s ~/mine/nvim.lua ~/.config/nvim
fi

#if test "${os}" = 'MSYS' -o "${os}" = 'CYGWIN'
#if [[ "${os}" = 'MSYS' -o "${os}" = 'CYGWIN' ]]
#if [[ "${os}" = 'MSYS' ]] || [[ "${os}" = 'CYGWIN' ]]
if [[ ${os} == "ubuntu" ]] || [[ ${os} == "debian" ]] || [[ ${os} == "elementary" ]]; then
    VERSION_ID=$(cat /etc/os-release|grep VERSION_ID|awk -F= '{print $2}')
    if [[ ${VERSION_ID} == "14.04" ]] && [[ ${os} == "ubuntu" ]] && [[ ! -d ~/{DOWNLOADS_NAME}/ag ]]; then
        git clone https://github.com/ggreer/the_silver_searcher ~/${DOWNLOADS_NAME}/ag
        if [[ $? -eq 0 ]]; then
            cd ~/${DOWNLOADS_NAME}/ag && ./build.sh && sudo make install
        else
            echo "install ag failed!"
        fi
    else
        sudo apt update && apt install -y silversearcher-ag
    fi
    sudo apt install -y curl wget build-essential zsh tmux libncurses5-dev lua5.3 \
         python3-pip cmake autoconf pkg-config fzf ripgrep universal-ctags autojump golang lm-sensors ranger
    # gui
    #sudo apt install thunar feh rofi
elif [[ ${os} == 'ManjaroLinux' ]] || [[ ${os} == 'arch' ]]; then
    sudo pacman -Sy base-devel curl wget zsh tmux fzf the_silver_searcher fd figlet ripgrep fd python go unzip \
         thefuck global tig cmake universal-ctags bat tldr python-pip librime emacs neovim inetutils rustup ranger archlinux-keyring gvfs \
         net-tools dnsutils inetutils iproute2 tcpdump autojump
    # gui
    sudo pacman -S picom thunar feh rofi scrot maim slock xclip
    # vscode sync
    #sudo pacman -S gnome-keyring libsecret libgnome-keyring
fi

# trzsz is a simple file transfer tools, similar to lrzsz ( rz / sz ), and compatible with tmux.
# https://github.com/trzsz/trzsz
sudo python3 -m pip install trzsz

if [[ -d ~/.oh-my-zsh ]]; then
    mv ~/.oh-my-zsh ~/.oh-my-zsh.bak
fi

if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
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
            wget https://github.com/sharkdp/bat/releases/download/v0.18.3/bat-musl_0.18.3_amd64.deb \
                 -O ~/bin/bat_0.18.3_amd64.deb
            if [[ $? -eq 0 ]]; then
                sudo dpkg -i ~/bin/bat_0.18.3_amd64.deb
                rm ~/bin/bat_0.18.3_amd64.deb
            else
                echo "error: rm ~/bin/bat_0.18.3_amd64.deb"
            fi
        fi
    fi

    #install jq
    # if [[ ! -f ~/bin/jq ]] && [[ ! -f /usr/bin/jq ]]; then
    #     wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O ~/bin/jq
    #     if [[ $? -eq 0 ]]; then
    #         chmod +x ~/bin/jq
    #     else
    #         echo "error: chmod +x ~/bin/jq"
    #     fi
    # fi

    #ln -sf ~/mine/Other/v2ray/foxy.sh ~/bin/foxy.sh

    #install manssh (or stormssh)
    #https://github.com/xwjdsh/manssh
    # if [[ ! -f ~/bin/man ]]; then
    #     wget https://github.com/xwjdsh/manssh/releases/download/v0.5.1\
    #          /manssh_0.5.1_linux_amd64.tar.gz -O ~/${DOWNLOADS_NAME}/manssh.tar.gz
    #     if [[ $? -eq 0 ]]; then
    #         tar -zxvf ~/${DOWNLOADS_NAME}/manssh.tar.gz -C ~/bin/
    #     else
    #         echo "error: ar -zxvf ~/${DOWNLOADS_NAME}/manssh.tar.gz -C ~/bin/"
    #     fi
    # fi
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

#build emacs-26 with x
#https://mirrors.tuna.tsinghua.edu.cn/gnu/emacs/emacs-26.3.tar.gz
#https://www.reddit.com/r/emacs/comments/7c0ry9/insall_emacs_27_from_source_ubuntu_1710_notes/
#sudo apt install build-essential automake texinfo libjpeg-dev libncurses5-dev
#sudo apt install libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
#./configure --with-mailutils --with-modules

#build emacs-26 without x
# sudo apt install libgnutls28-dev
#./configure --without-x --with-mailutils --with-modules
if [[ ${os} == "ubuntu" ]] && [[ ! -d ~/${DOWNLOADS_NAME}/emacs ]] && [[ ${VERSION_ID} == "14.04" ]]; then
    wget https://mirrors.tuna.tsinghua.edu.cn/gnu/emacs/emacs-26.3.tar.gz -O ~/${DOWNLOADS_NAME}/emacs-26.3.tar.gz
    if [[ $? -eq 0 ]]; then
        sudo apt install build-essential automake texinfo libjpeg-dev libncurses5-dev
        sudo apt install libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
        cd ~/${DOWNLOADS_NAME}/emacs-26.3
        ./configure --with-mailutils --with-modules      
        make -j 8 && sudo make install
    fi
fi

BIN_CTAGS_FLAG=$(/usr/bin/ctags --version|grep Universal|wc -l)
# LOCAL_BIN_CTAGS_FLAG=$(/usr/local/bin/ctags --version|grep Universal|wc -l)

if [[ ! -d ~/${DOWNLOADS_NAME}/ctags ]] && \
       [[ ${os} != 'arch' ]] && \
       [[ ${os} != 'ManjaroLinux' ]] && \
       [[ ${BIN_CTAGS_FLAG} -ne 2 ]]; then
    git clone https://github.com/universal-ctags/ctags --depth 1 ~/${DOWNLOADS_NAME}/ctags
    cd ~/${DOWNLOADS_NAME}/ctags
    ./autogen.sh
    ./configure --prefix=/usr
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
       [[ ! -f /usr/local/bin/proxychains4 ]] && \
       [[ ${os} != 'arch' ]] && \
       [[ ${os} != 'ManjaroLinux' ]]; then
    git clone https://github.com/rofl0r/proxychains-ng.git ~/${DOWNLOADS_NAME}/proxychains-ng
    cd ~/${DOWNLOADS_NAME}/proxychains-ng
    ./configure --prefix=/usr --sysconfdir=/etc
    make
    sudo make install
    sudo make install-config
fi

#if [[ ! -f ~/${DOWNLOADS_NAME}/global-6.6.3.tar.gz ]] && \
#       [[ ${os} != 'arch' ]] && \
#       [[ ${os} != 'ManjaroLinux' ]] && \
#       [[ ${LOCAL_BIN_CTAGS_FLAG} -eq 2 ]] || [[ ${BIN_CTAGS_FLAG} -eq 2 ]]; then
#    wget http://tamacom.com/global/global-6.6.3.tar.gz -O ~/${DOWNLOADS_NAME}/global-6.6.3.tar.gz
#    cd ~/${DOWNLOADS_NAME}/
#    tar -zxvf global-6.6.3.tar.gz
#    if [[ ${LOCAL_BIN_CTAGS_FLAG} -eq 2 ]]; then
#        cd ~/${DOWNLOADS_NAME}/global-6.6.3/ && ./configure --with-universal-ctags=/usr/local/bin/ctags && make -j 4
#    elif [[ ${BIN_CTAGS_FLAG} -eq 2 ]]; then
#        cd ~/${DOWNLOADS_NAME}/global-6.6.3/ && ./configure --with-universal-ctags=/usr/bin/ctags && make -j 4
#    fi
#    if [[ $? -eq 0 ]]; then
#        sudo make install
#    else
#        echo "Compile global failed!!!!"
#        exit 1
#    fi
#fi

#if [[ ! -f ~/${DOWNLOADS_NAME}/ncdu-1.13.tar.gz ]]
#then
#    wget https://dev.yorhel.nl/download/ncdu-1.13.tar.gz -O ~/${DOWNLOADS_NAME}/ncdu-1.13.tar.gz
#    cd ~/${DOWNLOADS_NAME}
#    tar -zxvf ncdu-1.13.tar.gz
#    cd ~/${DOWNLOADS_NAME}/ncdu-1.13/ && ./configure && make -j 4 && sudo make install
#fi

# if [[ -f ~/.vimrc ]]; then
    # mv ~/.vimrc ~/.vimrc.bak
# fi
# ln -sf ~/mine/vimfiles/vimrc ~/.vimrc

if [[ -f ~/.tmux.conf ]]
then
    mv ~/.tmux.conf ~/.tmux.conf.bak
fi
# ln -s ~/mine/VIM/tmux.conf ~/.tmux.conf
# git clone --recursive https://github.com/fwar34/tmux-config.git ~/mine/tmux-config
git clone https://github.com/fwar34/tmux-config.git ~/mine/tmux-config
cd ~/mine/tmux-config && ./install.sh

if [[ -f ~/.zshrc ]]
then
    mv ~/.zshrc ~/.zshrc.bak
fi
ln -s ~/mine/VIM/zshrc.sh ~/.zshrc

# if [[ -f ~/.zshenv ]]
# then
#     mv ~/.zshenv ~/.zshenv.bak
# fi
# ln -s $PWD/zshenv ~/.zshenv
echo '. "$HOME/mine/VIM/zshenv.sh"' >> $HOME/.zshenv

# if [[ -f ~/.cargo/config ]]
# then
#     mv ~/.cargo/config ~/.cargo/config.bak
# fi
# ln -s ~/mine/VIM/cargo.config ~/.cargo/config

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
# ln -s ~/mine/vimfiles/gitconfig ~/.gitconfig
cp ~/mine/vimfiles/gitconfig ~/.gitconfig

if [[ ! -d ~/.pip ]]; then
    mkdir ~/.pip
fi
if [[ -f ~/.pip/pip.conf ]]; then
    mv ~/.pip/pip.conf ~/.pip/pip.conf.bak
fi
ln -s ~/mine/dotfiles/.pip/pip.conf ~/.pip/pip.conf

if [[ -f ~/.config/awesome/rc.lua  ]]; then
    mv ~/.config/awesome ~/.config/awesome.bak
fi
git clone --recurse-submodules --remote-submodules --depth 1 -j 2 https://github.com/fwar34/awesome-copycats.git ~/mine/awesome-copycats
ln -sf ~/mine/awesome-copycats ~/.config/awesome

if [[ -f /etc/sddm.conf ]]; then
    mv /etc/sddm.conf /etc/sddm.conf.bak
fi
sudo ln -sf $PWD/sddm.conf /etc/sddm.conf

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

cd ~/Downloads
# git clone https://github.com/joelthelion/autojump.git
# cd autojump
# ./install.py

# linux mount windows disk
# /dev/sdc1  /mnt/sdc1   ntfs-3g  users,uid=1000,gid=100,fmask=0113,dmask=0002,locale=zh_CN.utf8         0 0

# virtualbox
# 1、安装基本包
# sudo pacman -S virtualbox : 选择virtualbox-host-modules-arch模块
# sudo pacman -S virtualbox-guest-iso
# 2、加载 VirtualBox 内核模块
# sudo modprobe vboxdrv vboxnetadp vboxnetflt
# vboxdrv驱动模块
# vboxnetadp 桥接网络
# vboxnetflthost-only 网络
# vboxpci：若要让虚拟机使用主体机的 PCI 设备，那么就需要这个模块。
# 3、安装扩展包
# yay -S virtualbox-ext-oracle
# 4、把当前用户组添加到vboxusers里面
# sudo usermod -G vboxusers -a 用户名

# archlinux 设置默认的浏览器，在 /usr/share/applications 中查找应用程序入口
# xdg-settings set default-web-browser microsoft-edge-beta.desktop
# xdg-settings get default-web-browser 显示当前默认浏览器

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
#https://mirrors.tuna.tsinghua.edu.cn/gnu/emacs/emacs-26.3.tar.gz
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

#常用命令
#B)find grep awk sed tr xargs cat tail head less top cut nl strings(打印文件中可打印的文本,可打印库或者执行文件) ldd

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
# ln -sf /mnt/c/Windows/Fonts/ ~/.fonts
# 清除字体缓存
# fc-cache
# 生成中文环境
# sudo locale-gen zh_CN.UTF-8
#////////////////////////////////////////////////////////////////////
# git for window alias in ~/.bashrc
# alias gst='git status'
# alias gl='git pull'
# alias gp='git push'
# alias gcmsg='git commit -m'
# alias gco='git checkout'
# alias gcl='git clone'
# alias gd='git diff'
# alias ga='git add'
