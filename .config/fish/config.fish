# Disable fish greeting
set -g fish_greeting

# Interactive session
if status is-interactive
    # Load aliases
    if test -f ~/.alias
        source ~/.alias
    end
end
