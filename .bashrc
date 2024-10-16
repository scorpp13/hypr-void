# ~/.bashrc

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash prompt
PS1='
\e[1;35m\u\e[0;37m@\e[2;37m\h\e[0;37m: \e[0;36m\w
\e[1;34m=> \e[m'

# Define aliases
if [ -f ~/.my_aliases ]; then
    . ~/.my_aliases
fi

# Start fastfetch if gui
echo ""
if [[ $(tty) == *"pts"* ]]; then
    fastfetch -c /usr/share/fastfetch/presets/examples/8.jsonc
fi

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

if [ -d /etc/bash/bashrc.d/ ]; then
    for f in /etc/bash/bashrc.d/*.sh; do
        [ -r "$f" ] && . "$f"
    done
    unset f
fi
