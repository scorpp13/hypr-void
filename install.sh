#!/bin/bash
set -u

GREEN='\033[0;32m'

TARGET_USER="${SUDO_USER:-$USER}"

# Update xbps + repo config
sudo xbps-install -Syu xbps

ARCH="$(xbps-uhelper arch)"
echo "repository=https://mirror.black-hole.dev/${ARCH}" | sudo tee /etc/xbps.d/20-repository-extra.conf >/dev/null

sudo xbps-install -S void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree

# Copy dotfiles (require the script run from the dotfiles directory)
cp -a .config "$HOME/"
cp -a .local "$HOME/"
cp -a .vim "$HOME/"
cp -a .Xresources .bash_profile .bashrc .gtkrc-2.0 .alias .vimrc "$HOME/"

sudo cp -f issue /etc/

# Install necessary packages
mapfile -t PKGS < <(sed -e 's/[[:space:]]*#.*$//' -e '/^[[:space:]]*$/d' necessary-packages)
sudo xbps-install -S "${PKGS[@]}"

# pipx install
pipx install waypaper

# ALSA config symlinks
sudo mkdir -p /etc/alsa/conf.d/
sudo ln -sf /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/50-pipewire.conf
sudo ln -sf /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/99-pipewire-default.conf

# PipeWire config symlinks
sudo mkdir -p /etc/pipewire/pipewire.conf.d/
sudo ln -sf /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/10-wireplumber.conf
sudo ln -sf /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/20-pipewire-pulse.conf

# System service links
for i in dbus socklog-unix nanoklogd NetworkManager elogind; do
  if [ -e "/etc/sv/$i" ]; then
    sudo ln -sf "/etc/sv/$i" "/var/service/$i"
  fi
done

# Remove conflicting services (if present)
for i in wpa_supplicant dhcpcd; do
  sudo rm -f "/var/service/$i"
done

# Add user to socklog group
sudo gpasswd -a "$TARGET_USER" socklog

# Postinstall reconfigure
sudo xbps-reconfigure -fa

# Reboot
echo -e "${GREEN}"
echo "Installation completed, press Enter to reboot"
read
sudo reboot
