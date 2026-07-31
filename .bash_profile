# ~/.bash_profile

# Include user variables from .bashrc
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# If login is nonroot start gui-session, else use console
if shopt -q login_shell; then
    [[ -f ~/.bashrc ]] && source ~/.bashrc
    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && dbus-run-session start-hyprland
else
    exit 1 # Somehow this is a non-bash or non-login shell
fi
