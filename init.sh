#!/bin/sh
sudo pacman -Sy ansible git && git clone https://github.com/voltamage/dotfiles.git /home/artix/dotfiles && ansible-playbook /home/artix/dotfiles/local.yml --ask-vault-pass
