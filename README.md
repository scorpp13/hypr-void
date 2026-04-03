<details><summary>Click to preview</summary>

<img src="preview/merge_090326_094246.jpg" width="400"/>

<img src="preview/merge_120326_194954.jpg" width="400"/>

<img src="preview/merge_030426_194948.jpg" width="400"/>

</details>

# My config files for Hyprland

A working configuration of Hyprland for Void Linux

## Installation

- [ ] Install void-base system

- `void-installer | login:root password:voidlinux`

- [ ] After restart run full-update

- `xbps-install -u xbps`

- `xbps-install -Su void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree`

- `xbps-install -Su`

- [ ] Install git package

- `xbps-install -S git`

- [ ] Clone git-repo or download and extract it to your $HOME

- `git clone` from one of those locations:

- `https://gitlab.com/scorpp13/hypr-void.git`

- `https://github.com/scorpp13/hypr-void.git`

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
