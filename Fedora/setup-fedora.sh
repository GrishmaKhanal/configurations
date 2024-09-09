#!/bin/bash

# Exit on error
set -e

# Define flag file
FLAG_FILE="/tmp/setup_done.flag"

# Function for pre-reboot tasks
pre_reboot_tasks() {
    # Remove unused packages
    echo "Removing unused packages..."
    sudo dnf remove -y libreoffice*
    sudo dnf autoremove -y

    # Configure dnf to be faster
    echo "Configuring dnf for faster operations..."
    sudo tee /etc/dnf/dnf.conf <<EOF
[main]
max_parallel_downloads=10
EOF

    # System update and reboot
    echo "Updating system..."
    sudo dnf update --refresh -y
    sudo dnf autoremove -y
    sudo dnf clean all

    # Create flag file and reboot system
    touch "$FLAG_FILE"
    echo "Rebooting system..."
    sudo reboot
}

# Function for post-reboot tasks
post_reboot_tasks() {
    # Adding RPM Fusion repos
    echo "Adding RPM Fusion repositories..."
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    # Add Flathub repository
    echo "Adding Flathub repository..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    # Install software
    echo "Installing software..."
    sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda discord steam vlc lutris

    # Install Flatpak applications
    echo "Installing Flatpak applications..."
    flatpak install -y com.google.Chrome dev.vencord.Vesktop io.missioncenter.MissionCenter com.github.tchx84.Flatseal org.prismlauncher.PrismLauncher org.qbittorrent.qBittorrent

    # Install GNOME Tweaks and Extensions Manager if using GNOME
    if gnome-shell --version &> /dev/null; then
        echo "Installing GNOME Tweaks and Extensions Manager..."
        sudo dnf install -y gnome-tweaks
        flatpak install -y com.mattjakeman.ExtensionManager
    fi

    # Clone GitHub repository and run setup script
    cd ~/Workspace/Different-Config/Fedora
    cp begin.sh ~/begin.sh
    chmod +x ~/begin.sh

    # Configure Git
    echo "Configuring Git..."
    git config --global user.name "GrishmaKhanal"
    git config --global user.email grishmakhanal48@gmail.com

    # Remove flag file after completion
    rm "$FLAG_FILE"

    # Final message
    echo "\nThis setup did not install VSCode, and configured zsh"
    echo "Setup complete."
    rm ~/setup-fedora.sh
}

# Main logic
if [ -f "$FLAG_FILE" ]; then
    echo "Setup already completed or system has been rebooted."
    post_reboot_tasks
else
    pre_reboot_tasks
fi
