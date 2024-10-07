# 🚀 Manual installation (copy and paste to terminal)

1. install all needed apps

```
sudo pacman -S --needed swaybg jq cmake cmocka ranger wofi waybar mtools vim neovim zsh \
papirus-icon-theme noto-fonts-emoji wl-clipboard translate-shell slurp \
grim pamixer wmname xdg-desktop-portal-wlr xdg-desktop-portal-gtk kanshi alacritty \
kitty pavucontrol playerctl imv mpv wayvnc swayidle mako gnome-themes-extra \
gtk-engine-murrine ttf-jetbrains-mono ttf-nerd-fonts-symbols

sudo usermod -a -G video $USER
```

2. clone dotfiles and change current directory to project directory (do any steps below from it)

```
git clone --depth 1 https://github.com/owpk/dotfiles-swayfx
cd dotfiles-swayfx
```

3. change shell to zsh

```
chsh -s /bin/zsh $USER
```

4. create your config backups if needed (hide errors)

```
mkdir ~/sway_backups.old

mv ~/.zshenv ~/sway_backups.old/.zshenv.bak 2> /dev/null
mv ~/.zshrc ~/sway_backups.old/.zshrc.bak 2> /dev/null
mv ~/.p10k.zsh ~/sway_backups.old/.p10k.zsh.bak 2> /dev/null
mv ~/.config ~/sway_backups.old/.config.bak 2> /dev/null
mv ~/.vim ~/sway_backups.old/.vim.bak 2> /dev/null
mv ~/.themes/ ~/sway_backups.old/.themes.bak 2> /dev/null
mv ~/.azotebg ~/sway_backups.old/.azote.bak 2> /dev/null
```

4.1 create all needed links and copy fonts

```
sudo mkdir -p /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
sudo cp ./config/sway/scripts/floating /usr/local/bin

fc-cache

ln -s `pwd`/.config ~/.config
ln -s `pwd`/.themes ~/.themes
```

5. install 'yay' package manager

```
pacman -Sy --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

6. install menus/toolbars/utils etc for sway

- use `gpg --receive-keys` if any errors occures

```
yay -S --needed swww avizo nwg-launchers nwg-panel wlsunset sworkstyle audio-recorder waybar-mpris-git
```

---

(Optional) install ranger devicons

```
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
```

---

Reboot your system
