#!/bin/bash
set -Eeuo pipefail
trap 'printf "Error on line %d: %s\n" "$LINENO" "$BASH_COMMAND" >&2' ERR

GREEN=$'\033[0;32m'
CYAN=$'\033[0;36m'
RESET=$'\033[0m'
TARGET_USER="$(id -un)"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# The script must be run as a normal user.
if [[ $EUID -eq 0 ]]; then
    echo "Run this script as a normal user, not with sudo." >&2
    exit 1
fi

cd "$SCRIPT_DIR"

# Required files in the dotfiles repository
required_files=(
    .config
    .local
    .vim
    .Xresources
    .bash_profile
    .bashrc
    .gtkrc-2.0
    .alias
    .vimrc
    issue
    necessary-packages
)

for file in "${required_files[@]}"; do
    if [[ ! -e "$file" ]]; then
        echo "Missing required file: $SCRIPT_DIR/$file" >&2
        exit 1
    fi
done

echo "Updating xbps..."

sudo xbps-install -u xbps
sudo xbps-install -Syu

# Enable required repositories
sudo xbps-install -y \
    void-repo-multilib \
    void-repo-multilib-nonfree \
    void-repo-nonfree

# Configure the custom repository.
REPO_ARCH="$(xbps-uhelper arch)"
REPO_FILE="/usr/share/xbps.d/00-repository-main.conf"
TARGET_REPO_FILE="/etc/xbps.d/00-repository-main.conf"

sudo install -d -m 0755 /etc/xbps.d

if [[ -f "$REPO_FILE" ]]; then
    sudo cp "$REPO_FILE" "$TARGET_REPO_FILE"
else
    printf '%s\n' \
        'repository=https://repo-default.voidlinux.org/current' |
        sudo tee "$TARGET_REPO_FILE" >/dev/null

    sudo chmod 0644 "$TARGET_REPO_FILE"
fi

# Remove an existing copy of the custom repository, if present.
sudo sed -i \
    '\|^repository=https://mirror\.black-hole\.dev/|d' \
    "$TARGET_REPO_FILE"

# Add the custom repository before the main repository.
sudo sed -i \
    "1i repository=https://mirror.black-hole.dev/${REPO_ARCH}/" \
    "$TARGET_REPO_FILE"

sudo xbps-install -S

# Read and clean the package list
mapfile -t PKGS < <(
    awk '
        {
            sub(/[[:space:]]*#.*/, "")
            for (i = 1; i <= NF; i++)
                print $i
        }
    ' necessary-packages
)

if (( ${#PKGS[@]} == 0 )); then
    echo "necessary-packages is empty." >&2
    exit 1
fi

# Check package availability before changing user or system configuration.
echo "Checking whether the complete package transaction is valid..."

if ! sudo xbps-install -n "${PKGS[@]}"; then
    echo "The package transaction cannot be completed." >&2
    exit 1
fi

echo "All required packages are available and installable."

# Install packages after the availability check.
echo "Installing packages..."
sudo xbps-install "${PKGS[@]}"

# Back up existing user settings before overwriting them.
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_path() {
    local path="$1"

    if [[ -e "$HOME/$path" || -L "$HOME/$path" ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$path")"
        cp -a "$HOME/$path" "$BACKUP_DIR/$path"
    fi
}

USER_SETTINGS=(
    .config
    .local
    .vim
    .Xresources
    .bash_profile
    .bashrc
    .gtkrc-2.0
    .alias
    .vimrc
)

for path in "${USER_SETTINGS[@]}"; do
    backup_path "$path"
done

echo "Existing user settings backed up to:"
echo "  $BACKUP_DIR"

# Copy dotfiles and overwrite files with the dotfiles version.
# Existing unrelated files inside these directories are preserved.
cp -a .config "$HOME/"
cp -a .local "$HOME/"
cp -a .vim "$HOME/"

cp -a \
    .Xresources \
    .bash_profile \
    .bashrc \
    .gtkrc-2.0 \
    .alias \
    .vimrc \
    "$HOME/"

# Install the system issue file.
sudo cp -f issue /etc/issue

# pipx uses ~/.local/bin, but the newly copied .bashrc is not loaded
# into the current installer process.
export PATH="$HOME/.local/bin:$PATH"

if pipx list 2>/dev/null | grep -q 'package waypaper'; then
    pipx upgrade waypaper
else
    pipx install waypaper
fi

for file in \
    /usr/share/alsa/alsa.conf.d/50-pipewire.conf \
    /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf \
    /usr/share/examples/wireplumber/10-wireplumber.conf \
    /usr/share/examples/pipewire/20-pipewire-pulse.conf
do
    if [[ ! -e "$file" ]]; then
        echo "Required configuration file not found: $file" >&2
        exit 1
    fi
done

# ALSA configuration
sudo mkdir -p /etc/alsa/conf.d

sudo ln -sfn \
    /usr/share/alsa/alsa.conf.d/50-pipewire.conf \
    /etc/alsa/conf.d/50-pipewire.conf

sudo ln -sfn \
    /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf \
    /etc/alsa/conf.d/99-pipewire-default.conf

# PipeWire configuration
sudo mkdir -p /etc/pipewire/pipewire.conf.d

sudo ln -sfn \
    /usr/share/examples/wireplumber/10-wireplumber.conf \
    /etc/pipewire/pipewire.conf.d/10-wireplumber.conf

sudo ln -sfn \
    /usr/share/examples/pipewire/20-pipewire-pulse.conf \
    /etc/pipewire/pipewire.conf.d/20-pipewire-pulse.conf

# Enable system services
for service in dbus socklog-unix nanoklogd NetworkManager elogind; do
    if [[ -d "/etc/sv/$service" ]]; then
        sudo ln -sfn "/etc/sv/$service" "/var/service/$service"
    else
        echo "Warning: service not found: $service" >&2
    fi
done

# Disable conflicting services
for service in wpa_supplicant dhcpcd; do
    sudo rm -f "/var/service/$service"
done

# Add the desktop user to the socklog group if necessary
if ! id -nG "$TARGET_USER" | grep -qw socklog; then
    sudo gpasswd -a "$TARGET_USER" socklog
fi

# Reconfigure installed packages
sudo xbps-reconfigure -fa

# Finish installation and reboot
printf '%s\n' "Installation completed."
printf '%sBackup: %s%s\n' "$CYAN" "$BACKUP_DIR" "$RESET"

read -r -p "${GREEN}Press Enter to reboot, or Ctrl-C to cancel...${RESET} " _
sudo reboot
