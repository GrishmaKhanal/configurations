#!/bin/bash
echo "Installing"
sudo pacman -S --needed --noconfirm - < packages.txt
xargs flatpak install -y < flatpaks.txt

# install gnome
echo "Installing $gnome."
sudo pacman -S --needed --noconfirm - < gnome/packages.txt
xargs flatpak install -y < gnome/flatpaks.txt
xargs sudo systemctl enable < gnome/services.txt
break;;

read -p "Do you want to install the nvidia drivers? y/n: " choice
case $choice in
[yY]* ) sudo pacman -S --needed --noconfirm - < nvidia.txt ;;
[nN]* ) echo "Skipped nvidia driver installation" ;;
*) echo "Invalid selection, skipping" ;;
esac

echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo Done!
