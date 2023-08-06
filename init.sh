#!/bin/sh
sudo pacman -Syyu --noconfirm ansible git && git clone https://github.com/voltamage/dotfiles.git /home/artix/dotfiles && ansible-playbook /home/artix/dotfiles/local.yml --ask-vault-pass && cd /home/artix/dotfiles && git remote remove origin && git remote add origin git@github.com:voltamage/dotfiles.git && cd ~/ 
