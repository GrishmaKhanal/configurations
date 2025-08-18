### Kernel Parameters

- In `/etc/cmdline.d/my_cmdline.conf`

  Add following and save (quite boot, without messages)
  ```
  quiet nowatchdog
  ```

- In `/etc/mkinitcpio.d/linux.preset`

  Append to `fallback_options`
  ```
  --cmdline /etc/kernel/cmdline
  ```

- Finally

  After performing all your kernel parameter modifications, rebuild the uki
  ```
  sudo mkinitcpio -p linux
  ```

### watchdog status

- See watchdog status with `cat /proc/sys/kernel/watchdog`

- See watchdog device status with `wdctl`

### bootloader display timeout

- In `/boot/loader/loader.conf`
  ```
  timeout 0
  ```
  to not display the bootloader menu during boot

### Yay
Yet Another Yogurt - An AUR Helper Written in Go
```
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
```

### zsh alias
```
cat zsh_alias.txt << ~/.zshrc
```


*This is a personalized version from /archlinux/archlinux/\**
