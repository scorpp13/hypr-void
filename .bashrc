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

# Bash_prompt
PROMPT_DIRTRIM=3

build_prompt() {
    local EXIT="$?"
    local RST='\[\e[0m\]'
    local DIM='\[\e[38;2;108;112;134m\]'       # Catppuccin Overlay
    local C_USER='\[\e[1;38;2;203;166;247m\]'  # Soft Mauve
    local C_DIR='\[\e[1;38;2;137;180;250m\]'   # Crisp Blue
    local C_OK='\[\e[1;38;2;166;227;161m\]'    # Mint Green
    local C_ERR='\[\e[1;38;2;243;139;168m\]'   # Coral Red

    local ARROW="${C_OK}❯${RST}"
    local ERR_CODE=""
    if [ "$EXIT" != "0" ]; then
        ARROW="${C_ERR}❯${RST}"
        ERR_CODE=" ${C_ERR}✘ ${EXIT}${RST}"
    fi

    PS1="\n${DIM}[bash] ${C_USER}\u${DIM}@\h ${C_DIR}\w${ERR_CODE}\n${ARROW} "
}

PROMPT_COMMAND=build_prompt

shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend
