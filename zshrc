# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

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
alias tmux='tmux -2'
#alias tmux='TERM=xterm-256color  tmux -2'

if [ -f '/usr/local/bin/vim' ]
then
    alias vi='/usr/local/bin/vim'
    alias vim='/usr/local/bin/vim'
else
    alias vi='vim'
fi

if [ -f '/usr/local/bin/emacs' ]
then
    alias emacs='/usr/local/bin/emacs'
fi

if [ -f '/usr/local/bin/tmux' ]
then
    alias tmux='/usr/local/bin/tmux -2'
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

alias cs='emacs -nw'
#bindkey  "^[[H"   beginning-of-line
#bindkey  "^[[F"   end-of-line

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line
export PKG_CONFIG_PATH=/tang/lib/pkgconfig/:$PKG_CONFIG_PATH
#vim man page
export MANPAGER="vim -c MANPAGER -"
#https://segmentfault.com/a/1190000002789600
export MSYS="winsymlinks:lnk"

gvim()
{
    OLD_HOME=$HOME
    OLD_VIMRUNTIME=$VIMRUNTIME
    export HOME=/i/msys64/home/fwar3
    export VIMRUNTIME="C:\Program Files (x86)\Vim\vim81"
    TARGET=$(cygpath -w $1) 
    (/c/Program\ Files\ \(x86\)/Vim/vim81/gvim.exe $TARGET &)
    export HOME=$OLD_HOME
    export VIMRUNTIME=$OLD_VIMRUNTIME 
} 

if [ "$TERM" = "xterm" ]; then
    export TERM=xterm-256color
fi

ulimit -c unlimited
unsetopt share_history

[[ -s /home/linux/.autojump/etc/profile.d/autojump.sh  ]] && source /home/linux/.autojump/etc/profile.d/autojump.sh

[[ -s /home/liang.feng/.autojump/etc/profile.d/autojump.sh  ]] && source /home/liang.feng/.autojump/etc/profile.d/autojump.sh

[[ -s /home/fwar3/.autojump/etc/profile.d/autojump.sh ]] && source /home/fwar3/.autojump/etc/profile.d/autojump.sh

gvim2() {
    ORIGHOME=$HOME
    HOME=/cygdrive/i/home/fwar3
    /cygdrive/c/Program\ Files\ \(x86\)/Vim/vim80/gvim.exe $1 & disown
    HOME=$ORIGHOME
} 2>/dev/null

autoload -U compinit && compinit -u

#alias tmux="TERM=screen-256color tmux -2"
#export TERM=screen-256color

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
