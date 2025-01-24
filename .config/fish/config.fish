# Start Hyprland on nonroot TTY-login (for login shell = fish)
#if status --is-login
#  if test -z "$DISPLAY" -a $XDG_VTNR = 1
#    exec Hyprland
#  end
#end

# Disable fish greeting
set -U fish_greeting

# Enable pywal colors
#cat ~/.cache/wal/sequences

# Interactive session
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases
if [ -f ~/.alias ]
    source ~/.alias
end
