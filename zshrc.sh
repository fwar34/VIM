# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/bin:$PATH:/snap/bin:$HOME/.local/bin:$HOME/.local/share/nvim/lsp_servers/pylsp/venv/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="ys"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#####################################################################################
# 这个代码块放到最前面
if [[ $(uname -r|awk -F- '{print $2}') == "microsoft" ]]; then
    NAMESERVER_LINE_NUM=$(cat /etc/resolv.conf|grep nameserver|wc -l)
    if [[ ${NAMESERVER_LINE_NUM} -gt 1 ]]; then
        # wsl
        export DISPLAY=:0.0
        export LIBGL_ALWAYS_INDIRECT=1
        #export DOCKER_HOST=tcp://localhost:2375
    elif [[ $(uname -n|grep esxi|wc -l) -eq 1 ]]; then
        export DISPLAY=192.168.125.52:0.0
        export LIBGL_ALWAYS_INDIRECT=1
    else
        # wsl2
        export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
        export LIBGL_ALWAYS_INDIRECT=1
        #export DOCKER_HOST=tcp://$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):2375
    fi

    # fix interop
    fix_wsl2_interop() {
        for i in $(pstree -np -s $$ | grep -o -E '[0-9]+'); do
            if [[ -e "/run/WSL/${i}_interop" ]]; then
                export WSL_INTEROP=/run/WSL/${i}_interop
            fi
        done
    }

fi

if [[ -f "/etc/os-release" ]]; then
	OS_NAME=$(head -1 /etc/os-release|awk -F\" '{print $2}')
	OS_VERSION=$(grep VERSION_ID /etc/os-release|awk -F\" '{print $2}')
fi

CN_CODE=zh_CN.utf8
EN_CODE=en_US.utf8

# for wsl docker build
if [[ ${OS_NAME} == "Ubuntu" ]] && [[ ${OS_VERSION} == "14.04" ]]; then
    export LC_ALL=
    export LANG=${EN_CODE}
    #export LANGUAGE=zh_CN.utf8
    #export LC_MESSAGES=zh_CN.utf8
    export LC_CTYPE=${CN_CODE}
else #其他正常的linux
    export LC_ALL=
    export LANG=${EN_CODE}
    export LC_CTYPE=${CN_CODE}
fi
#####################################################################################

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# export LANG=en_US.utf-8

#https://blog.csdn.net/gengli2017/article/details/82917827
#https://blog.csdn.net/yangyiwxl/article/details/72865371
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    alias ls='ls --show-control-chars --color=auto'
    alias ll='ls -lht'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#alias tmux='tmux -2'
alias tmux='tmux -u'
#alias tmux='TERM=xterm-256color  tmux -2'

alias nv='nvim'
# if [ -f '/usr/local/bin/vim' ]
# then
#     alias vi='TERM=xterm-256color /usr/local/bin/vim'
#     alias vim='TERM=xterm-256color /usr/local/bin/vim'
# else
#     if [[ -f "/usr/bin/nvim" ]]; then
#         alias vi="nvim"
#         alias vim="nvim"
#     else
#         alias vi='TERM=xterm-256color vim'
#     fi
# fi

if [ -f '/usr/local/bin/emacs' ]
then
    alias emacs='/usr/local/bin/emacs'
fi

if [ -f '/usr/local/bin/tmux' ]
then
    #alias tmux='/usr/local/bin/tmux -2'
    alias tmux='/usr/local/bin/tmux'
    #alias tmux='TERM=screen-256color-bce /usr/local/bin/tmux -2'
    #alias tmux='TERM=xterm-256color /usr/local/bin/tmux -2'
fi

if [ -f '/usr/local/bin/bear' ]
then
    alias bear='/usr/local/bin/bear'
fi

if [ -f '~/.vim/plugged/YCM-Generator/config_gen.py' ]
then
    alias config_gen='~/.vim/plugged/YCM-Generator/config_gen.py'
fi

if [[ -f "/usr/bin/ctags" ]] && [[ $(/usr/bin/ctags --version|grep Universal|wc -l) -eq 2 ]]; then
    alias ctags='/usr/bin/ctags'
elif [ -f '/usr/local/bin/ctags' ]; then
    alias ctags='/usr/local/bin/ctags'
fi

if [[ -f '/usr/bin/setxkbmap' ]] && [[ ${XDG_SESSION_TYPE} == "x11" ]]
then
	setxkbmap -option ctrl:nocaps
fi

# if [ "$TERM" = "xterm" ]
# then
    #export TERM=xterm-256color
# fi

#https://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux
#if [[ -z $TMUX  ]]; then
#    if [ -e /usr/share/terminfo/x/xterm+256color  ]; then # may be xterm-256 depending on your distro
#        export TERM='xterm-256color'
#    else
#        export TERM='xterm'
#    fi
#else
#    if [ -e /usr/share/terminfo/s/screen-256color  ]; then
#        export TERM=xterm-256color
        #export TERM=screen-256color
#    else
#        export TERM='screen'
#    fi
#fi

# {{{
# https://www.cnblogs.com/Cherry-Linux/p/9053002.html
# 修改.zshrc配置文件，添加下列配置。
# [[ $TMUX = ""  ]] && export TERM="xterm-256color"
# 修改.tmux.conf配置文件，添加下列配置（如果此文件不存在，直接创建即可。）
# set -g default-terminal "screen-256color"
# }}}

#alias tmux="TERM=screen-256color tmux -2"
#export TERM=screen-256color

alias cs='emacs -nw'
alias csd='emacs -nw --dump-file="/home/feng/.emacs.d/emacs.pdmp"'


#https://www.jianshu.com/p/006517cc260e
#fix emacs gui not run in elementary
#if [ $(lsb_release -i|cut -f2) = 'elementary' ]; then
if [[ -f "/etc/os-release" ]] && [ "$(head -1 /etc/os-release|awk -F\" '{print $2}')" = 'elementary' ]; then
    alias emacs="XLIB_SKIP_ARGB_VISUALS=1 emacs"
fi

#bindkey  "^[[H"   beginning-of-line
#bindkey  "^[[F"   end-of-line

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line
# export PKG_CONFIG_PATH=/tang/lib/pkgconfig/:$PKG_CONFIG_PATH
#vim man page
#export MANPAGER="vim -c MANPAGER -"
#https://segmentfault.com/a/1190000002789600

ulimit -c unlimited
unsetopt share_history

# [[ -s /home/linux/.autojump/etc/profile.d/autojump.sh  ]] && source /home/linux/.autojump/etc/profile.d/autojump.sh
# [[ -s /home/liang.feng/.autojump/etc/profile.d/autojump.sh  ]] && source /home/liang.feng/.autojump/etc/profile.d/autojump.sh
# [[ -s /home/fwar3/.autojump/etc/profile.d/autojump.sh ]] && source /home/fwar3/.autojump/etc/profile.d/autojump.sh
# [[ -s /home/feng/.autojump/etc/profile.d/autojump.sh ]] && source /home/feng/.autojump/etc/profile.d/autojump.sh

autoload -U compinit && compinit -u

if [ -d ~/.linuxbrew ] || [ -d ~/.linuxbrew ]
then
    test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
fi

# #golang
# export GOPATH=$HOME/go
# export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/bin/maven/bin
# #golang proxy
# export GO111MODULE=on
# export GOPROXY=https://goproxy.cn

#tldr
export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='green'
export TLDR_CODE='red'
export TLDR_PARAM='blue'
#complete -W "$(tldr 2>/dev/null --list)" tldr
#tldr在zsh中设置成和man命令一样的补全 https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org
compdef tldr=man
compdef cheat=man

#ncdu
alias ncdu='ncdu --color dark -rr -x'


alias gproxy_http="git config --global http.proxy http://127.0.0.1:1080"
alias gproxy_socks="git config --global http.proxy socks5://127.0.0.1:1080"
alias gunproxy="git config --global --unset http.proxy && git config --global --unset https.proxy"

alias pc="proxychains4"
alias pclone="proxychains4 git clone"
alias ppush="proxychains4 git push"
alias ppull="proxychains4 git pull"

alias docker-trunk="docker start trunk && docker exec -it trunk /bin/zsh"
alias docker-dev="docker start dev && docker exec -it dev /bin/zsh"

#thefuck https://github.com/nvbn/thefuck
#eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
#eval $(thefuck --alias FUCK)

# if [ -d /usr/lib/jvm/java-11-openjdk-amd64 ];then
#     export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# elif [ -d /usr/lib/jvm/java-8-openjdk-amd64 ];then
#     export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#     export JRE_HOME=${JAVA_HOME}/jre
#     export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
# elif [ -d /usr/lib/jvm/java-8-openjdk ];then
#     export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#     export JRE_HOME=${JAVA_HOME}/jre
#     export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
# else
#     export JAVA_HOME=/home/feng/jdk-13.0.2
# fi
# export PATH=$PATH:$JAVA_HOME/bin

# export MAVEN_HOME=/usr/share/maven
# export PATH=$PATH:$MAVEN_HOME/bin

# export ROCKETMQ_HOME=/home/feng/rocketMQ/rocketmq-all-4.6.1-bin-release

###WSL####################################################################

# https://wiki.archlinux.org/index.php/Fcitx_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
# 1. 当 LC_CTYPE 为英文时, 在 Emacs 上可能无法使用输入法。若遇到此情况，请在启动
# Emacs 时将 LC_CTYPE 设为 zh_CN.UTF-8. 终端下并不会遇到此现象，因为输入法会交给终端程序处理。 
# 2. 而且必须设置fcitx的3个环境变量:
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

alias vxemacs='setsid emacs'
alias vxemacsd='setsid emacs --dump-file="/home/feng/.emacs.d/emacs.pdmp"'
alias vxterm='setsid xfce4-terminal'
alias vxidea='setsid idea'
alias vxecli='setsid eclipse'

if [[ $(uname -r|awk -F- '{print $3}') = 'Microsoft' ]]; then
    alias cdc="cd /c/" 
    alias cdd="cd /d/" 
    alias cde="cd /e/" 
    alias cdf="cd /f/" 
    alias cdg="cd /g/" 
fi
###WSL####################################################################

## for rust
## export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
#
#export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static 
#export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
#
## for brew
#export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# https://www.zhihu.com/question/338022694
# polipo
alias proxyhon='export http_proxy=http://127.0.0.1:8123 https_proxy=http://127.0.0.1:8123'

# clash in win10
alias proxyopen='export http_proxy=http://192.168.169.1:7890 https_proxy=http://192.168.169.1:7890'
alias proxyoff='unset http_proxy https_proxy'

#alias rn='ranger'

# https://github.com/fdw/ranger-autojump/blob/main/ranger-autojump.plugin.zsh
# Add a `r` function to zsh that opens ranger either at the given directory or
# at the one autojump suggests
rn() {
  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      ranger "$1"
    else
      ranger "$(autojump $1)"
    fi
  else
    ranger
  fi
	return $?
}

function subv2ray
{
    sudo subsystemctl start
    sudo subsystemctl exec systemctl start v2ray
    sudo subsystemctl exec systemctl start sshd
}

# https://www.jianshu.com/p/2c1ac913d2cb
# 我开始设置的是zsh，我发现，当我用$cd$命令改变工作目录的时候，emacs里的default-directory这个变量没有改变，
# 使得C-x C-f调用打开文件时目录不是当前工作目录？
# INSIDE_EMACS 变量是 multi-term 包中定义的变量
if [ -n "$INSIDE_EMACS" ]; then
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi

# {{{
# vterm https://github.com/akermu/emacs-libvterm
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}


if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
    alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
fi

autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ print -Pn "\e]2;%m:%2~\a" }

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

# if [[ "$INSIDE_EMACS" = 'vterm' ]] \
#        && [[ -n ${EMACS_VTERM_PATH} ]] \
#        && [[ -f ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
#     source ${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh
# fi
# }}}

# {{{ esp8266
# export IDF_PATH=$HOME/esp/ESP8266_RTOS_SDK
# export PATH=$PATH:$HOME/esp/xtensa-lx106-elf/bin/
#"esptool.py write_flash -fm qio 0x00000 ~/esp/nodemcu-release-18-modules-2022-05-22-07-05-45-integer.bin" 可以用--port指定串口
alias espflash="esptool.py write_flash --erase-all -fm qio 0x00000"
alias nu="nodemcu-uploader"
alias pc="picocom /dev/ttyUSB0 -b115200"
alias am="ampy --port /dev/ttyUSB0"

# pyboard.py device
# https://docs.micropython.org/en/latest/reference/pyboard.py.html
export PYBOARD_DEVICE=/dev/ttyUSB0
# }}}

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
