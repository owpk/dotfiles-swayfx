#!/bin/bash
set -e

DOT=$(pwd)

git config user.name "$USER"
git config user.email "--auto--"

# Install yay
if ! command -v yay > /dev/null
then
	sudo pacman -Sy --needed git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

	cd $DOT
	sudo rm -rf yay
fi


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

#AUR packages
AUR=(
swww 
nwg-launchers 
nwg-panel 
wlsunset 
waybar-mpris-git
avizo
)

# The script begins here.
pac() {
    yay -S --noconfirm --needed $1
}

# Install utilities
for i in ${PACKAGES[@]}; do
  pac $i
done

# Install utilities
for i in ${AUR[@]}; do
  pac $i
done

TERM_UTILS="server-dots"
CFG=$HOME/.config
LOCAL_BIN=$HOME/.local/bin
mkdir -p $LOCAL_BIN 2> /dev/null
mkdir -p $CFG 2> /dev/null

stow --adopt -vt $CFG .config
stow --adopt -vt $LOCAL_BIN scripts 

sudo mkdir -p /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
fc-cache

ln -nsf $(pwd)/.themes $HOME/

# install terminal utils
git submodule update --init --recursive

# Создаем и переключаемся на новую ветку в основном проекте
git checkout -b "$USER"

cd $TERM_UTILS
./install.sh
