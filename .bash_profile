# ~/.bash_profile

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

# Set user_executibale PATH
if [ -d "$HOME/.config/scripts" ] ; then
	export PATH="$HOME/.config/scripts:$PATH"
fi
#
if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Check if XDG_RUNTIME_DIR is set
if test -z "$XDG_RUNTIME_DIR"; then
	if test ! -d "$XDG_RUNTIME_DIR" ; then
		mkdir $XDG_RUNTIME_DIR
		chown $USER:$USER $XDG_RUNTIME_DIR
	fi
	export XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
fi

# If login is nonroot start session gui, else use console
if shopt -q login_shell; then
    [[ -f ~/.bashrc ]] && source ~/.bashrc
    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && dbus-run-session Hyprland
else
    exit 1 # Somehow this is a non-bash or non-login shell
fi
