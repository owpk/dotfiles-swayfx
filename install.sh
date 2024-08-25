#!/bin/bash
set -e

# Configuration
USER_NAME=$1 # user name

PACKAGES=(
swaybg 
jq 
cmake 
cmocka 
wofi 
waybar 
mtools 
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

# TODO switched to yay
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

# TODO switched to yay
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

stow --adopt -vt ./.config .config

sudo mkdir /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
fc-cache

echo "Script has finished. Please reboot your PC using 'reboot' command."
exit
