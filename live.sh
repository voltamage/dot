#!/bin/sh
# Stop the reflector service that comes with the arch live environment
# This way we can run it with our own settings without mirrorlist conflicts
# BUG: If reflector service doesn't exist this errs
systemctl stop reflector.service

# Expand disk, configure pacman, and ensure tmux is installed
mount -o remount,size=75% /run/archiso/cowspace
sed -i 's/#Color/Color/g' /etc/pacman.conf
sed -i 's/#VerbosePkgLists/VerbosePkgLists/g' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 12/g' /etc/pacman.conf
# this step sometimes seems to get stuck with git sometimes
pacman -Sy --needed --noconfirm git reflector tmux

# Start tmux session, update mirrorlist, system, and basic packages
# dotfiles step is not idempotent
tmux new-session -A -d -s live
tmux send-keys -t live "\
reflector --sort rate -c US -p https --delay 1 --save /etc/pacman.d/mirrorlist -x berkeley && \
pacman -Syu ansible btop ranger --needed --noconfirm --ignore linux --ignore linux-lts --ignore linux-zen && \
ansible-galaxy collection install kewlfft.aur && \
if cd ~/dotfiles; then git pull; else git clone https://github.com/voltamage/dotfiles ~/dotfiles; fi && \
ansible-playbook ~/dotfiles/tasks/init.yml --ask-vault-pass && \
ansible-playbook ~/dotfiles/tasks/system.yml" Enter
