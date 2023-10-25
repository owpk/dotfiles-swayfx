#!/bin/bash
set -e

# Configuration
USER_NAME=$1 # user name

PACKAGES=(
swaybg 
jq 
cmake 
cmocka 
ranger 
wofi 
waybar 
mtools 
vim 
neovim 
zsh 
vifm 
papirus-icon-theme 
noto-fonts-emoji 
ttf-hack 
wl-clipboard 
translate-shell 
slurp
grim 
light 
pamixer 
wmname 
dmenu 
xdg-desktop-portal 
kanshi 
alacritty
kitty 
pavucontrol 
playerctl 
imv 
mpv 
wayvnc 
pkcs11-helper 
nodejs 
swayidle
stow 
)

AURA=(
avizo
nwg-launchers
nwg-wrapper
wlsunset
sworkstyle
azote
)

# The script begins here.
pac() {
    sudo pacman -Syu --noconfirm --needed $1
}

aur() {
    sudo aura -A $1
}

# Install utilities
for i in ${EXTENSIONS[@]}; do
  pac $i
done

# Install aura
git clone https://aur.archlinux.org/aura-bin.git
chown -R $USER_NAME aura-bin
cd ./aura-bin
sudo makepkg -si

cd ..
rm -rf ./aura-bin

# Install aur packages
for i in ${AURA[@]}; do
  aur $i
done

# Services
systemctl enable avizo

BACKUP_DIR="/home/$USER_NAME/.sway_backups.old"
mkdir -p $BACKUP_DIR

mv ~/.zshenv $BACKUP_DIR/.zshenv.bak 2> /dev/null
mv ~/.zshrc $BACKUP_DIR/.zshrc.bak 2> /dev/null
mv ~/.p10k.zsh $BACKUP_DIR/.p10k.zsh.bak 2> /dev/null
#mv ~/.config $BACKUP_DIR/.config.bak 2> /dev/null
#mv ~/.vim $BACKUP_DIR/.vim.bak 2> /dev/null

ln -s `pwd`/.zshenv ~/.zshenv
ln -s `pwd`/.config/zsh/.zshrc ~/.zshrc
ln -s `pwd`/.p10k.zsh ~/.p10k.zsh

stow --adopt -vt ./.config .config
stow --adopt -vt ./.vim .vim

sudo mkdir /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
fc-cache

echo "Script has finished. Please reboot your PC using 'reboot' command."
exit
