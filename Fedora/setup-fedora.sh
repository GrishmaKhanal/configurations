#!/bin/bash

# Exit on error
set -e

# Define flag file
FLAG_FILE="/tmp/setup_done.flag"
# Function for pre-reboot tasks
pre_reboot_tasks() {
    # Remove unused packages
    echo "Removing unused packages..."
    sudo dnf remove -y libreoffice-core totem rhythmbox simple-scan
    sudo dnf autoremove -y
    sudo flatpak remote-delete fedora
    sudo flatpak remote-delete fedora-testing
    sudo rm /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:phracek:PyCharm.repo /etc/yum.repos.d/google-chrome.repo

    # System update and reboot
    echo "Updating system..."
    sudo dnf update --refresh -y
    sudo dnf autoremove -y

    # Create flag file and reboot system
    touch "$FLAG_FILE"
    echo "Rebooting system..."
    sudo reboot
}

# Function for post-reboot tasks
post_reboot_tasks() {
    # Adding RPM Fusion repos
    # Remove the remaining rpm fusion in /etc/yum.repos.d if you go this route ---
    # sudo rm /etc/yum.repos.d/rpmfusion-nonfree-steam.repo /etc/yum.repos.d/rpmfusion-nonfree-nvidia-driver.repo
    # sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    # Add Flathub repository
    echo "Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    # Install software
    echo "Installing software..."
    # sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda steam fastfetch gnome-tweaks zsh gh expect lutris
    sudo dnf install -y fastfetch gnome-tweaks zsh gh expect

    # Install Flatpak applications
    echo "Installing Flatpak applications..."
    xargs flatpak install -y < flatpak-files.txt
    sudo dnf remove firefox -y

    # echo "Loading Custom Keybindings - Gnome"
    # cd Keybindings/
    # dconf load /org/gnome/shell/keybindings/ < bkp_shell
    # dconf load /org/gnome/desktop/wm/keybindings/ < bkp_wm
    # dconf load /org/gnome/settings-daemon/plugins/media-keys/ < bkp_media
    # cd ~

    # Final message & getting oh my zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "\nThis setup did not install VSCode"
    echo "Setup complete."
    read -p "Press Enter to Complete: "

    # Remove flag file after completion
    rm "$FLAG_FILE"
}

# Main logic
if [ -f "$FLAG_FILE" ]; then
    echo "Press Enter to Continue to run post reboot tasks."
    read -p "Press Enter to Continue: "
    post_reboot_tasks
else
    read -p "Press Enter to Continue to run updates and cleaning: "
    pre_reboot_tasks
fi
