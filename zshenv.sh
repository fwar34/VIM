#!/bin/sh

# {{{
# https://www.cnblogs.com/Cherry-Linux/p/9053002.html
# 修改.zshrc配置文件，添加下列配置。
# [[ $TMUX = ""  ]] && export TERM="xterm-256color"
# INSIDE_EMACS 变量是 multi-term 包中定义的环境变量
[[ $TMUX = "" ]] && [[ $INSIDE_EMACS = "" ]] && export TERM="xterm-256color"
# 修改.tmux.conf配置文件，添加下列配置（如果此文件不存在，直接创建即可。）
# set -g default-terminal "screen-256color"
# }}}

export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/bin:$PATH:/snap/bin:$HOME/.local/bin:$HOME/.local/share/nvim/lsp_servers/pylsp/venv/bin
#golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/bin/maven/bin
#golang proxy
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

if [ -d /usr/lib/jvm/java-11-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
elif [ -d /usr/lib/jvm/java-8-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
elif [ -d /usr/lib/jvm/java-8-openjdk ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
else
    export JAVA_HOME=$HOME/jdk-13.0.2
fi
export PATH=$PATH:$JAVA_HOME/bin

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fd --hidden --follow -E ".git" -E "node_modules" -E ".svn" -E "debian" . /etc $HOME'
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
_fzf_compgen_path() {
  fd --hidden --follow -E ".git" -E "node_modules" . -E ".svn" -E "debian" /etc $HOME
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow -E ".git" -E "node_modules" -E ".svn" -E "debian" . /etc $HOME
}
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

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static 
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# for brew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# export GTK_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export QT_IM_MODULE=fcitx

# export GTK_IM_MODULE=fcitx5
# export QT_IM_MODULE=fcitx5
# export XMODIFIERS=@im=fcitx5