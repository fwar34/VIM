# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/sbin:$PATH

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
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
export LANG=en_US.utf-8
alias ls='ls --show-control-chars --color=auto'

alias ll='ls -lht'
#alias tmux='tmux -2'
alias tmux='tmux -u'
#alias tmux='TERM=xterm-256color  tmux -2'

alias nv='nvim'
if [ -f '/usr/local/bin/vim' ]
then
    alias vi='TERM=xterm-256color /usr/local/bin/vim'
    alias vim='TERM=xterm-256color /usr/local/bin/vim'
else
    alias vi='TERM=xterm-256color vim'
fi

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

if [ -f '/usr/local/bin/ctags' ]
then
    alias ctags='/usr/local/bin/ctags'
fi

if [ "$TERM" = "xterm" ]
then
    export TERM=xterm-256color
fi

#https://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux
#if [[ -z $TMUX  ]]; then
#    if [ -e /usr/share/terminfo/x/xterm+256color  ]; then # may be xterm-256 depending on your distro
#        export TERM='xterm-256color'
#    else
#        export TERM='xterm'
#    fi
#else
#    if [ -e /usr/share/terminfo/s/screen-256color  ]; then
#        export TERM='screen-256color'
#    else
#        export TERM='screen'
#    fi
#fi

alias cs='emacs -nw'
#bindkey  "^[[H"   beginning-of-line
#bindkey  "^[[F"   end-of-line

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line
export PKG_CONFIG_PATH=/tang/lib/pkgconfig/:$PKG_CONFIG_PATH
#vim man page
#export MANPAGER="vim -c MANPAGER -"
#https://segmentfault.com/a/1190000002789600
export MSYS="winsymlinks:lnk"

gvim()
{
    OLD_HOME=$HOME
    OLD_VIMRUNTIME=$VIMRUNTIME
    OLD_TERM=$TERM

    #{{{
    # for fzf in windows-->https://github.com/junegunn/fzf/wiki/Windows
    export TERM=
    #}}}
    if [ -d /i/msys64/home/fwar3 ]
    then
        export HOME=/i/msys64/home/fwar3
    elif [ -d /e/msys64/home/liang.feng ]
    then
        export HOME=/e/msys64/home/liang.feng
    fi

    vim80="/c/Program Files (x86)/Vim/vim80"
    vim81="/c/Program Files (x86)/Vim/vim81"

    if [ -d $vim81 ]
    then
        export VIMRUNTIME="C:\Program Files (x86)\Vim\vim81"
        TARGET=$(cygpath -w $1) 
        (/c/Program\ Files\ \(x86\)/Vim/vim81/gvim.exe $TARGET &)
    elif [ -d $vim80 ]
    then
        export VIMRUNTIME="C:\Program Files (x86)\Vim\vim80"
        TARGET=$(cygpath -w $1) 
        (/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe $TARGET &)
    fi

    export HOME=$OLD_HOME
    export VIMRUNTIME=$OLD_VIMRUNTIME 
    export TERM=$OLD_TERM
} 

#gviml()
#{
    #OLD_HOME=$HOME
    #OLD_VIMRUNTIME=$VIMRUNTIME
    #export HOME=/e/msys64/home/liang.feng
    #export VIMRUNTIME="C:\Program Files (x86)\Vim\vim80"
    #TARGET=$(cygpath -w $1) 
    #(/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe $TARGET &)
    #export HOME=$OLD_HOME
    #export VIMRUNTIME=$OLD_VIMRUNTIME 
#} 


ulimit -c unlimited
unsetopt share_history

[[ -s /home/linux/.autojump/etc/profile.d/autojump.sh  ]] && source /home/linux/.autojump/etc/profile.d/autojump.sh

[[ -s /home/liang.feng/.autojump/etc/profile.d/autojump.sh  ]] && source /home/liang.feng/.autojump/etc/profile.d/autojump.sh

[[ -s /home/fwar3/.autojump/etc/profile.d/autojump.sh ]] && source /home/fwar3/.autojump/etc/profile.d/autojump.sh

gvim3() {
    ORIGHOME=$HOME
    HOME=/cygdrive/i/home/fwar3
    /cygdrive/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe $1 & disown
    HOME=$ORIGHOME
} 2>/dev/null

autoload -U compinit && compinit -u

#alias tmux="TERM=screen-256color tmux -2"
#export TERM=screen-256color

if [ -d ~/.linuxbrew ] || [ -d ~/.linuxbrew ]
then
    test -d ~/.linuxbrew && PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
    test -d /home/linuxbrew/.linuxbrew && PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
    test -r ~/.bash_profile && echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.bash_profile
    echo "export PATH='$(brew --prefix)/bin:$(brew --prefix)/sbin'":'"$PATH"' >>~/.profile
fi

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
    export LESS=-r
}
man_color4

export TZ='Asia/Shanghai'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

#thefuck https://github.com/nvbn/thefuck
eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias FUCK)
