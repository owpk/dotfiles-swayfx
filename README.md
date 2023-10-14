## My dotfiles for [SwayFx](https://github.com/WillPower3309/swayfx) sway fork  

- press ```Win + p``` to show keybindigs help
- press ```Win + Shift + p``` to toggle keybindigs help 
- SEE .config/sway/config.d/input TO CHANGE KEYBOARD LAYOUT AND OTHER KB SETTINGS
- SEE .config/sway/config.d/default TO CHANGE KEY BINDINGS CONFIG

<p align="center">
   <img src="https://github.com/owpk/dotfiles-swayfx/blob/main/docs/sc.gif"/>
</p>
<p align="center">
   <img src="https://github.com/owpk/dotfiles-swayfx/blob/main/docs/composed.jpg"/>
</p>

# Install for arch linux (copy and paste to terminal)

1. install all needed apps
```
sudo pacman -S --needed swaybg jq cmake cmocka ranger wofi waybar mtools vim neovim zsh \
vifm papirus-icon-theme noto-fonts-emoji ttf-hack wl-clipboard translate-shell slurp \
grim light pamixer wmname dmenu xdg-desktop-portal kanshi gnome-keyring alacritty \
kitty pavucontrol playerctl imv mpv wayvnc pkcs11-helper nodejs sworkstyle

sudo usermod -a -G video $USER
```
2. clone dotfiles
```
git clone https://github.com/owpk/dotfiles-swayfx
cd dotfiles-swayfx
```
3. change shell to zsh
```
chsh -s /bin/zsh $USER
```
4. install zsh utils
- TYPE 'exit' AND PRESS ENTER WHEN OHMYZSH WILL BE INSTALLED 
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
5. create all needed links and copy fonts
```
sudo mkdir /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
fc-cache
mv ~/.zshenv ~/.zshenv.bak 2> /dev/null
ln -s `pwd`/.zshenv ~/.zshenv
mv ~/.zshrc ~/.zshrc.bak 2> /dev/null
ln -s `pwd`/.config/zsh/.zshrc ~/.zshrc
mv ~/.p10k.zsh ~/.p10k.zsh.bak 2> /dev/null
ln -s `pwd`/.p10k.zsh ~/.p10k.zsh
mv ~/.config ~/.config.bak 2> /dev/null
ln -s `pwd`/.config ~/.config
mv ~/.vim ~/.vim.bak 2> /dev/null
ln -s `pwd`/.vim ~/.vim
```

6. install 'aura'

```
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U *.tar.zst
```

7. install menus/toolbars/utils etc for sway
 - install last app if you have networkmanager installed
 - use ```gpg --receive-keys``` if any errors occures
```
sudo aura -A avizo
sudo aura -A nwg-launchers
sudo aura -A wlsunset
sudo aura -A azote
sudo aura -A networkmanager-dmenu-git
```

7.1. (Optional) install ranger devicons
```
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
```
8. run sway (from terminal) to ensure if everything is ok and reboot system
```
sway
reboot
```

9. change background image 
```
pkill swaybg
MONITOR="$(swaymsg -t get_outputs | jq -r '.[] | {name} | (.name)')"
nohup swaybg -o $MONITOR -i "$HOME/dotfiles-swayfx/wallpapers/wp.png" -m fill &
```
 - or use 'azote' app to do the same as above 😺  

# useful links
- [sway fx](https://github.com/WillPower3309/swayfx)
- [sway wm](https://github.com/swaywm/sway)
- [waybar (status bar)](https://github.com/Alexays/Waybar)
- [wofi (menus/launchers)](https://hg.sr.ht/~scoopta/wofi)
- [mako (wayland notification daemon)](https://github.com/emersion/mako)
- [nwg-launchers (menus/launchers)](https://github.com/nwg-piotr/nwg-launchers)
- [wob (wayland overlay bar)](https://github.com/francma/wob)
- [aura (AUR helper)](https://github.com/fosskers/aura)

# issues

- vmware: black screen after sway launch   
	adding WLR_NO_HARDWARE_CURSORS=1 to /etc/environment may fix the problem

