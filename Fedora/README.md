    # fedora-config

# remove unused packages

```
sudo dnf remove libreoffice*
sudo dnf autoremove
```

# make dnf faster

```
sudo nano /etc/dnf/dnf.conf
```

Add these lines:

```
max_parallel_downloads=10
fastestmirror=True
```

# system update

```
sudo dnf update --refresh
```

reboot


# Repos RPM fusion

```
dnf repolist
ls /etc/yum.repos.d
```
remove unnessary repos

Add this repo
```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

```
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

just in case
```
sudo dnf config-manager --enable fedora-cisco-openh264
```

## Installing 
```
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda
```

```
sudo dnf install discord steam vlc -y
```
+
```
vscode
```

## Flatpak Installing

```
Chrome
Vesktop
Mission Center
Flatseal
Prism Launcher
qBittorrent
```

```
flatpak install com.google.Chrome dev.vencord.Vesktop io.missioncenter.MissionCenter com.github.tchx84.Flatseal org.prismlauncher.PrismLauncher org.qbittorrent.qBittorrent
```

If on Gnome:

```
sudo dnf install gnome-tweaks
flatpak install com.mattjakeman.ExtensionManager
```


# Settings

- Build Profile 1 Kde Transparency
- Refresh Rate to 165
- Enable HDR & increase SDR to 300
- Dark mode
- if kde change keyboard shortcut:
    super + up -> Maximize Windows
    super + shift + s -> Capture Rectangular Region
    Print -> Spectacle
    super + tab -> Toggle Present Windows (Current desktop)
    super + shift + tab -> Toggle Present Windows (All Desktops)


## Clone from github
```
mkdir Workspace
cd Workspace
git clone https://github.com/GrishmaKhanal/Different-Config.git
```
```
cd Different-Config/Fedora
cp begin.sh ../../../
chmod +x begin.sh
```

Add GPU_System_Monitor.page to System Monitor (super + esc)


# Config Git
```
git config --global user.name "GrishmaKhanal"
git config --global user.email grishmakhanal48@gmail.com
```
# add zsh with ohmyzsh as default terminal

zsh

```
sudo dnf install zsh
```

ohmyzsh

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

change default shell to zsh

```
chsh -s $(which zsh)
```

reboot



# or run the script

Before running the script check the repolist

```
cd /etc/yum.repos.d/
ls -l
```

```
cd ~
mkdir Workspace
cd Workspace
git clone https://github.com/GrishmaKhanal/Different-Config.git
```

```
cd Different-Config/Fedora
cp setup-fedora.sh ../../../
chmod +x setup-fedora.sh
```