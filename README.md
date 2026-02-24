<img src="https://i.ibb.co/8PPKHmG/merge-190125-140315.png" width="400"/>

# My config files for Hyprland

A working configuration of Hyprland for Void Linux

## Installation

- [ ] Clone git-repo or download and extract it to your $HOME
- `git clone https://gitlab.com/scorpp13/hypr-void.git`
- [ ] Change to hypr-void directory
- `cd $HOME/hypr-void/`
- [ ] Copy files and folders from it to your $HOME
- `cp -r .config .local .vim .Xresources .bash_profile .bashrc .gtkrc-2.0 .alias .vimrc $HOME`
- [ ] Install necessary software from list
- `sudo xbps-install -S ...`
- [ ] For tty-login you can change default issue
- `sudo cp issue /etc/`
- [ ] For systems with sound card sof-essx8336 copy preconfig file
- `sudo cp alsa-base.conf /etc/modprobe.d/`
- [ ] Reboot your machine
- `sudo reboot`
- [ ] Enjoy
- `^;^`
