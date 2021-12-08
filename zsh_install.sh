#!/bin/bash

sudo apt install zsh autojump tmux
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    #sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ -f ~/.zshrc ]]
then
    mv ~/.zshrc ~/.zshrc.bak
fi
ln -s ~/mine/VIM/zshrc.sh ~/.zshrc

if [[ -f ~/.zshenv ]]
then
    mv ~/.zshenv ~/.zshenv.bak
fi
ln -s $PWD/zshenv ~/.zshenv

# if [[ -f ~/.tmux.conf ]]
# then
#     mv ~/.tmux.conf ~/.tmux.conf.bak
# fi
# ln -s ~/mine/VIM/tmux.conf ~/.tmux.conf
echo '. "$HOME/mine/VIM/zshenv.sh"' >> $HOME/.zshenv
