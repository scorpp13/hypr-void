# ~/.bashrc

# Shell is non-interactive. Be done now!
if [[ $- != *i* ]] ; then
	return
fi

# Set user_executable PATH
if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Set system default editor
export EDITOR="vim"

# Define source aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

# Show fastfetch if run gui-session
echo ""
if [[ $(tty) == *"pts"* ]]; then
    fastfetch -c examples/27.jsonc
fi

# Bash prompt
PS1='
\e[1;35m\u\e[0;37m@\e[2;37m\h\e[0;37m: \e[0;36m\w
\e[1;34m=> \e[m'

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend
