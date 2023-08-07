#!/bin/sh
sudo pacman -Syyu --noconfirm ansible git && git clone https://github.com/voltamage/dotfiles.git ~/dotfiles && ansible-playbook ~/dotfiles/local.yml --ask-vault-pass -v && cd ~/dotfiles && git remote remove origin && git remote add origin git@github.com:voltamage/dotfiles.git && cd ~/
