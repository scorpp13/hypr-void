# .bashrc

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

# Change the window title of X terminals 
case ${TERM} in
	[aEkx]term*|rxvt*|gnome*|konsole*|interix|tmux*)
		PS1='\[\033]0;\u@\h:\w\007\]'
		;;
	screen*)
		PS1='\[\033_\u@\h:\w\033\\\]'
		;;
	*)
		unset PS1
		;;
esac

# Set colorful PS1 only on colorful terminals
use_color=false
if type -P dircolors >/dev/null ; then
	LS_COLORS=
		if [[ -f ~/.dir_colors ]] ; then
			eval "$(dircolors -b ~/.dir_colors)"
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval "$(dircolors -b /etc/DIR_COLORS)"
		else
			eval "$(dircolors -b)"
		fi
	if [[ -n ${LS_COLORS:+set} ]] ; then
		use_color=true
		else
			unset LS_COLORS
	fi
		else
			case ${TERM} in
				[aEkx]term*|rxvt*|gnome*|konsole*|screen|tmux|cons25|*color) use_color=true;;
			esac
fi
if ${use_color} ; then
	if [[ ${EUID} == 0 ]] ; then
		PS1+='\[\033[01;31m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
	else
		PS1+='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi
else
	# Show root@ when we don't have colors
	PS1+='\u@\h \w \$ '
fi
for sh in /etc/bash/bashrc.d/* ; do
	[[ -r ${sh} ]] && source "${sh}"
done
unset use_color sh
