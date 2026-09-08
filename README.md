<details><summary>Click to preview</summary>
<img src="preview/merge_120826_202638.jpg" width="800"/>
<img src="preview/merge_120326_194954.jpg" width="800"/>
<img src="preview/merge_140826_185810.jpg" width="800"/>
</details>

# Hypr-Void environment

A working configuration of Hyprland for Void Linux
- A new config based on lua script language.
- Old version based on hyprlang is also available.
- Dynamic desktop themes with pywal accent colors.

> [!NOTE]
> The Hypr-Void environment is designed for use with a clean installation of the Void Linux base system.<br>
> It can also be used on an existing system. A new installation script will create a backup of your configuration files.<br>
> During installation, the script will check your system before making any changes.<br>
> If anything goes wrong, the script will exit. You can later check for errors before making changes.<br>
> Please note that Hypr-Void is not officially supported in Void Linux.<br>
> The necessary binaries are used from a third-party repository. Some of these may be disabled or conflict with system libraries.<br>
> In this case, you can remove them from necessary-packages. I don't recommend doing this. Otherwise, the Hypr-Void environment will not function properly.<br>
> <b>Modifiable applications that do not affect the Hypr-Void environment are user-defined applications:</b><br>
> browser, terminal, gui editor, gui file manager, cli file manager, media player, and volume control.

## Installation

#### Install void-base system from latest live cd
```
void-installer 
```

#### After system restart install git package and clone hypr-void dotfiles
```
sudo xbps-install -S git
git clone https://github.com/scorpp13/hypr-void.git $HOME/hypr-void/
```
<details>
<summary>Click to view other mirrors</summary>
→ https://gitlab.com/scorpp13/hypr-void.git
<br>
→ https://codeberg.org/scorpp13/hypr-void.git
<br>
→ https://git.sourcecraft.dev/scorpp13/hypr-void.git
<br>
→ https://gitea.com/scorpp13/hypr-void.git
</details>

#### Change to dotfiles folder and start installation script
```
cd $HOME/hypr-void/
./install.sh
```
For systems with sound card sof-essx8336 copy preconfig file:
- `sudo cp alsa-base.conf /etc/modprobe.d/`
<br>

> [!CAUTION]
> Gum v2 have a lot of bugs, so my scripts don't work correctly with it.<br>
> To make all work download binary v1.7 from [official GitHub page](https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_Linux_x86_64.tar.gz).<br>
> Unpack archive and change binary v2 vs binary v1.7 (/usr/bin/gum).<br>
> You can also use included gum v1.7 binary, that was downloaded from official release page.

### Final steps

> [!WARNING]
> After first start of hyprland desktop:<br>
> -- Run waypaper, choose wallpapers folder and change to wallpaper you preffer.<br>
> -- Reload Hyprland instance (press SUPER+R) to dismiss warnings (no wal colors in cache).<br>
> -- Install your preffered apps and then run userapps.sh to integrate them into config.<br>
> <br>
> <b>Default applications:</b><br>
> - browser = vivaldi-stable<br>
> - terminal = kitty<br>
> - gui filemanager = thunar<br>
> - gui editor = geany<br>
> - cli filemanager = vifm<br>
> - mediaplayer = mpv<br>
> - volume control = pwvucontrol<br>

### Enjoy
#### `^;^`
