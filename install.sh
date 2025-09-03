#!/bin/bash

#ln -s ~/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
#ln -s ~/dotfiles/.vim ~/.vim
#ln -s ~/dotfiles/.vimrc ~/.vimrc
#ln -s ~/dotfiles/.gemrc ~/.gemrc
#ln -s ~/dotfiles/.irbrc ~/.irbrc

mkdir -p ~/.gnupg
ln -s ~/dotfiles/gpg-agent.conf ~/.gnupg/gpg-agent.conf

mkdir -p ~/.config
ln -s ~/dotfiles/.config/kitty ~/.config/kitty

#git submodule init
#git submodule update
