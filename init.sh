#!/bin/sh
sudo pacman -Sy --noconfirm ansible git && ansible-pull -U https://github.com/voltamage/dotfiles.git -v && ansible-playbook ~/dotfiles/sshkey.yml --ask-vault-pass -v && cd ~/dotfiles && git remote remove origin && git remote add origin git@github.com:voltamage/dotfiles.git && cd ~/ && ansible-playbook ~/dotfiles/stage2.yml -v
