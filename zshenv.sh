#!/bin/sh

# {{{
# https://www.cnblogs.com/Cherry-Linux/p/9053002.html
# 修改.zshrc配置文件，添加下列配置。
# [[ $TMUX = ""  ]] && export TERM="xterm-256color"
# INSIDE_EMACS 变量是 emacs 的 multi-term 包中定义的环境变量
[[ $TMUX = "" ]] && [[ $INSIDE_EMACS = "" ]] && export TERM="xterm-256color"
# 修改.tmux.conf配置文件，添加下列配置（如果此文件不存在，直接创建即可。）
# set -g default-terminal "screen-256color"
# }}}

# deno
export PATH=$PATH:$HOME/.deno/bin

# rustup
export PATH=$PATH:$HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin

# lsp server path
# LSP_SERVERS_PATH=$HOME/.local/share/nvim/lsp_servers
LSP_SERVERS=$HOME/.local/share/nvim/mason/bin
# LSP_SERVERS=$LSP_SERVERS_PATH/pylsp/venv/bin:$LSP_SERVERS_PATH/jedi_language_server/venv/bin
# LSP_SERVERS=$LSP_SERVERS:$LSP_SERVERS_PATH/go
# LSP_SERVERS=$LSP_SERVERS:$LSP_SERVERS_PATH/rust
# LSP_SERVERS=$LSP_SERVERS:$HOME/bin/lua-language-server/bin

export MYHOSTNAME=$(cat /etc/hostname)
export PATH=$PATH:$HOME/bin:/usr/local/bin:/sbin:/usr/bin:/snap/bin:$HOME/.local/bin:$LSP_SERVERS


#golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/bin/maven/bin
#golang proxy
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

if [ -d /usr/lib/jvm/java-11-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    export PATH=$PATH:$JAVA_HOME/bin
elif [ -d /usr/lib/jvm/java-8-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=$PATH:$JAVA_HOME/bin
elif [ -d /usr/lib/jvm/java-8-openjdk ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=$PATH:$JAVA_HOME/bin
#else
#    export JAVA_HOME=$HOME/jdk-13.0.2
fi

export MAVEN_HOME=/usr/share/maven
export PATH=$PATH:$MAVEN_HOME/bin

export ROCKETMQ_HOME=$HOME/rocketMQ/rocketmq-all-4.6.1-bin-release

[[ -s /home/linux/.autojump/etc/profile.d/autojump.sh  ]] && source /home/linux/.autojump/etc/profile.d/autojump.sh
[[ -s /home/liang.feng/.autojump/etc/profile.d/autojump.sh  ]] && source /home/liang.feng/.autojump/etc/profile.d/autojump.sh
[[ -s /home/fwar3/.autojump/etc/profile.d/autojump.sh ]] && source /home/fwar3/.autojump/etc/profile.d/autojump.sh
[[ -s /home/feng/.autojump/etc/profile.d/autojump.sh ]] && source /home/feng/.autojump/etc/profile.d/autojump.sh
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# {{{
# FZF 设置
# https://www.jianshu.com/p/aeebaee1dd2b
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

exclude1='-E "node_modules" . -E ".svn" -E "debian" -E ".subversion" -E ".deps" -E "*.o" -E "*.lo" -E "doxygen-doc" -E ".local/share/containers" -E "*.pyc" -E "*.pyi"'
exclude2='-E "*.a" -E "*.so" -E "*.class" -E "*.zip" -E "*.pyo" -E "*.iso" -E "*.swp" -E "*.obj" -E "*.exe" -E "*.pdb" -E "*.lib" -E "__pycache__"'
exclude3='-E "*.tar" -E "*.rar" -E "*.7z" -E "*.jar" -E "*.ttf" -E "*.pdf" -E "*.dll" -E "*.bz2" -E "*.xz" -E "*.gz" -E "*.gzip"'
exclude4='-E "*.png" -E "*.jpg" -E "*.gif" -E "*.bmp" -E "*.tga" -E "*.pcx" -E "*.ppm" -E "*.img" -E "tags"'

# export FZF_DEFAULT_COMMAND='fd --hidden --follow -E ".git" -E "node_modules" -E ".svn" -E "debian" -E ".subversion" -E ".deps" -E "*.o" -E "*.lo" -E "doxygen-doc"'
export FZF_DEFAULT_COMMAND="fd --hidden --follow ${exclude1} ${exclude2} ${exclude3} ${exclude4}"
# export FZF_DEFAULT_OPTS='--height 90% --layout=reverse --bind=alt-j:down,alt-k:up,alt-i:toggle+down --border --preview "echo {} | ~/linux-config-file/fzf/fzf_preview.py" --preview-window=down'

# use fzf in bash and zsh
# Use ~~ as the trigger sequence instead of the default **
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
#export FZF_COMPLETION_OPTS=''

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
  # fd --hidden --follow -E ".git" -E "node_modules" . -E ".svn" -E "debian" . /etc $HOME
  # fd --hidden --follow -E "node_modules" . -E ".svn" -E "debian" -E ".subversion" -E ".deps" -E "*.o" -E "*.lo" -E "doxygen-doc" -E ".local/share/containers" . "$1"
# }

# Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
  # fd --type d --hidden --follow -E ".git" -E "node_modules" -E ".svn" -E "debian" . /etc $HOME
  # fd --type d --hidden --follow -E "node_modules" . -E ".svn" -E "debian" -E ".subversion" -E ".deps" -E "*.o" -E "*.lo" -E "doxygen-doc" -E ".local/share/containers" . "$1"
# }
# }}}


export PKG_CONFIG_PATH=/tang/lib/pkgconfig/:$PKG_CONFIG_PATH

function man_color()
{
    # 放到你的 ~/.bashrc 配置文件中，给 man 增加漂亮的色彩高亮
    export LESS_TERMCAP_mb=$'\E[1m\E[32m'
    export LESS_TERMCAP_mh=$'\E[2m'
    export LESS_TERMCAP_mr=$'\E[7m'
    export LESS_TERMCAP_md=$'\E[1m\E[36m'
    export LESS_TERMCAP_ZW=""
    export LESS_TERMCAP_us=$'\E[4m\E[1m\E[37m'
    export LESS_TERMCAP_me=$'\E(B\E[m'
    export LESS_TERMCAP_ue=$'\E[24m\E(B\E[m'
    export LESS_TERMCAP_ZO=""
    export LESS_TERMCAP_ZN=""
    export LESS_TERMCAP_se=$'\E[27m\E(B\E[m'
    export LESS_TERMCAP_ZV=""
    export LESS_TERMCAP_so=$'\E[1m\E[33m\E[44m'
}

function man_color2()
{
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
}

function man_color3()
{
    export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
    export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
    export LESS_TERMCAP_me=$(tput sgr0)
    export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
    export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
    export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
    export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
    export LESS_TERMCAP_mr=$(tput rev)
    export LESS_TERMCAP_mh=$(tput dim)
    export LESS_TERMCAP_ZN=$(tput ssubm)
    export LESS_TERMCAP_ZV=$(tput rsubm)
    export LESS_TERMCAP_ZO=$(tput ssupm)
    export LESS_TERMCAP_ZW=$(tput rsupm)
}

function man_color4()
{
    #https://unix.stackexchange.com/questions/6010/colored-man-pages-not-working-on-gentoo
    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;47;34m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
    #export LESS=-r
}
man_color4

export TZ='Asia/Shanghai'

## for rust
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
# export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

# 字节跳动源 https://rsproxy.cn/
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# for brew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# {{{
# fcitx5
# https://blog.woshiluo.com/1693.html
# https://github.com/wongdean/rime-settings
# pacman -S fcitx5 fcitx5-qt fcitx5-gtk
# pacman -S fcitx5-chinese-addons fcitx5-rime
# 此时，Fcitx5 的配置文件在 ~/.config/fcitx5 下
#
# 1.2 Rime 的安装
# pacman -S librime 
# pacman -S rime-double-pinyin #需要双拼的话，安装这个
# 此时，Rime 的配置文件在 ~/.local/share/fcitx5/rime 下
if [[ $MYHOSTNAME == "ubuntu-awesome" ]]; then
    export GTK_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export QT_IM_MODULE=fcitx
else
    # export GTK_IM_MODULE=fcitx5
    # export QT_IM_MODULE=fcitx5
    # export XMODIFIERS=@im=fcitx5

    # export GTK_IM_MODULE=fcitx
    # export QT_IM_MODULE=fcitx
    # export XMODIFIERS=@im=fcitx
    # export GLFW_IM_MODULE=ibus

    # sudo pacman -S fcitx5-im 
    # sudo pacman -S fcitx5-chinese-addons  fcitx5-rime
    # 其中
    # fcitx5-chinese-addons 包含了大量中文输入方式：拼音、双拼、五笔拼音、自然码、仓颉、冰蟾全息、二笔等
    # fcitx5-rime 对经典的 Rime IME 输入法的包装，内置了繁体中文和简体中文的支持。
    # 下来配置输入法
    
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export INPUT_METHOD=fcitx
    export SDL_IM_MODULE=fcitx
    export GLFW_IM_MODULE=ibus
fi

# }}}

# awesome 相关
# sudo pacman -S alsa-utils feh picom dex dhcped
# fonts
# proxychains4 paru -S noto-fonts-sc nerd-fonts-jetbrains-mono ttf-iosevka-nerd

# {{{
# /etc/dhcpcd.conf 
# static ip
# interface enp5s0
# static ip_address=192.168.125.153/24
# static routers=192.168.125.3
# static domain_name_servers=192.168.125.3
# }}}

# https://wiki.archlinux.org/title/HiDPI_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
# 自从 Qt 5.6 开始，Qt 5 应用程序可以遵守屏幕DPI。设置环境变量QT_AUTO_SCREEN_SCALE_FACTOR以启用这项功能。
export QT_AUTO_SCREEN_SCALE_FACTOR=1

# https://wiki.archlinux.org/title/HiDPI#Java_applications
# GTK3
# 要将UI缩放为两倍大小：
# export GDK_SCALE=2
# 并同时不影响字体：
# export GDK_DPI_SCALE=0.5

# https://hkvim.com/post/windows-setup/
# export GDK_SCALE=2

# https://wiki.archlinux.org/title/Java#Gray_window,_applications_not_resizing_with_WM,_menus_immediately_closing
export AWT_TOOLKIT=MToolkit
