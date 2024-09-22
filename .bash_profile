# .bash_profile

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

if [ -d "$HOME/.config/scripts" ] ; then
export PATH="$HOME/.config/scripts:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
export PATH="$HOME/.local/bin:$PATH"
fi

#export USER="as"
#export HOME="/home/$USER"
export XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
mkdir $XDG_RUNTIME_DIR
chown $USER:$USER $XDG_RUNTIME_DIR
#groups="$(id -Gn "$USER" | tr ' ' ':')"
#svdir="$HOME/service"

# Ensure XDG_RUNTIME_DIR is set
#if test -z "$XDG_RUNTIME_DIR"; then
#    export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$(id -u)-runtime-dir.XXX)
#fi

# If login is nonroot start session gui, else use console
if shopt -q login_shell; then
    [[ -f ~/.bashrc ]] && source ~/.bashrc
    [[ -t 0 && $(tty) == /dev/tty1 && ! $DISPLAY ]] && exec Hyprland
else
    exit 1 # Somehow this is a non-bash or non-login shell
fi
