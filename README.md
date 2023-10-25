## My dotfiles for [SwayFx](https://github.com/WillPower3309/swayfx) sway fork  
### Also check my '[sway-keybindings helper](https://github.com/owpk/sway-keyhints)' project  

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
grim light pamixer wmname dmenu xdg-desktop-portal kanshi alacritty \
kitty pavucontrol playerctl imv mpv wayvnc pkcs11-helper nodejs swayidle

sudo usermod -a -G video $USER
```
2. clone dotfiles and change directory
```
git clone https://github.com/owpk/dotfiles-swayfx
cd dotfiles-swayfx
```
3. change shell to zsh
```
chsh -s /bin/zsh $USER
```
4. create all needed links and copy fonts
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

5. install 'aura'

```
git clone https://aur.archlinux.org/aura-bin.git
cd aura-bin
makepkg
sudo pacman -U *.tar.zst
```

6. install menus/toolbars/utils etc for sway
 - use ```gpg --receive-keys``` if any errors occures
```
sudo aura -A avizo
sudo aura -A nwg-launchers
sudo aura -A nwg-wrapper
sudo aura -A wlsunset
sudo aura -A sworkstyle
sudo aura -A azote
```

6.1. (Optional) install ranger devicons
```
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
```

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

