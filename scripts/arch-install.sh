ln -sf /usr/share/zoneinfo/Asia/Irkutsk /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
touch /etc/hostname
echo "owpk" > /etc/hostname
echo "127.0.0.1	  localhost" >> /etc/hosts
echo "::1	        localhost" >> /etc/hosts
echo "127.0.1.1   owpk.localdomain  owpk" >> /etc/hosts

pacman -S --needed networkmanager network-manager-applet bluez bluez-utils wireless_tools \
wpa_supplicant dialog reflector mtools vim neovim snapper os-prober grub efibootmgr zsh alacritty \
vifm papirus-icon-theme noto-fonts-emoji ttf-hack wl-clipboard translate-shell pamixer

echo "enter root password:"
passwd
echo "Creating user 'owpk'..."
useradd -g users -G wheel,storage,power,video -m owpk
echo "enter owpk password:"
passwd owpk

mkdir /usr/share/fonts/TTF
cp ./fonts/* /usr/share/fonts/TTF/
fc-cache

chmod +w /etc/sudoers
echo "owpk ALL=(ALL) ALL" >> /etc/sudoers

systemctl enable NetworkManager.service
systemctl enable bluetooth.service

echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

chsh -s /bin/zsh owpk

git clone https://github.com/owpk/dotfiles-sway /home/owpk/dotfiles-sway
chown -R owpk:users /home/owpk/dotfiles-sway

HOME=/home/owpk
DOT=$HOME/dotfiles-sway
mkdir /usr/share/fonts/TTF
cp $DOT/fonts/* /usr/share/fonts/TTF/
fc-cache

runuser -l owpk -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
runuser -l owpk -c 'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k'
runuser -l owpk -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'

rm $HOME/.config 2> /dev/null
ln -s $DOT/.config $HOME/.config
rm $HOME/.p10k.zsh 2> /dev/null
ln -s $DOT/.p10k.zsh $HOME/.p10k.zsh
rm $HOME/.zshrc 2> /dev/null
ln -s $DOT/.zshrc $HOME/.zshrc
rm -r $HOME/.vim 2> /dev/null
ln -s $DOT/.vim $HOME/.vim
rm -r /root/.vim 2> /dev/null
ln -s $DOT/.vim /root/.vim
