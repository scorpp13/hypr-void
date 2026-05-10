#!/bin/bash   
GREEN='\033[0;32m'
# Postinstall update and repository config
sudo xbps-install -u xbps
echo "
repository=https://raw.githubusercontent.com/Event-Horizon-VL/blackhole-vl/repository-x86_64
repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc
" | sudo tee /etc/xbps.d/20-repository-extra.conf
#echo repository=https://github.com/Encoded14/void-extra/releases/download/repository-x86_64 | sudo tee /etc/xbps.d/20-repository-extra.conf
sudo xbps-install -Su void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree
# Clone preconfigure from dotfiles
cp -r .config/ .local/ .vim/ .Xresources .bash_profile .bashrc .gtkrc-2.0 .alias .vimrc $HOME/
sudo cp issue /etc/
# Install necessary software
sudo xbps-install -S $(cat necessary-packages)
pipx install waypaper
# Update alsa config files
sudo mkdir -p /etc/alsa/conf.d/
sudo ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d/
sudo ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/
# Update pipewire config files
sudo mkdir -p /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
# Configure system services
for i in dbus socklog-unix nanoklogd NetworkManager elogind; do sudo ln -s /etc/sv/$i /var/service/; done
for i in wpa_supplicant dhcpcd; do sudo rm /var/service/$i; done
sudo gpasswd -a $USER socklog
# Postinstall reconfigure
sudo xbps-reconfigure -fa
# Finish installation and reboot
echo -e "${GREEN}"
echo "Installation completed, press Enter to reboot"
read
sudo reboot
