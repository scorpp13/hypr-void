# ~/.bash_profile

# Exit safely if not a login shell
shopt -q login_shell || return

# Load interactive settings from .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start Hyprland automatically on tty1 for non-root user
if [[ $EUID -ne 0 && -t 0 && $(tty) == /dev/tty1 && -z $DISPLAY && -z $WAYLAND_DISPLAY ]]; then
    exec dbus-run-session start-hyprland
fi
