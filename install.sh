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
pacman -Sy --needed --noconfirm reflector tmux

# Start tmux session, update mirrorlist, system, and basic packages
# Download configs into a tmp directory, and start archinstall
tmux new-session -A -d -s install
tmux send-keys -t install "\
reflector --sort rate -c US -p https --delay 1 --save /etc/pacman.d/mirrorlist -x berkeley && \
pacman -Syu archinstall btop ranger --needed --noconfirm --ignore linux --ignore linux-lts --ignore linux-zen && \
mkdir -p /tmp/archinstallconf && \
cd /tmp/archinstallconf && \
curl https://raw.githubusercontent.com/voltamage/dotfiles/main/files/user_configuration.json -O && \
curl https://raw.githubusercontent.com/voltamage/dotfiles/main/files/user_credentials.json -O && \
archinstall --config user_configuration.json --creds user_credentials.json && \
cd" Enter
