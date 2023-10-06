#!/bin/sh
echo "configure aurutils"
cd /tmp
git clone https://aur.archlinux.org/aurutils.git
cd aurutils
runuser -l owpk -c 'makepkg -si'
CUSTOM=/etc/pacman.d/custom
touch $CUSTOM
echo '[options]' >> $CUSTOM
echo 'CacheDir = /var/cache/pacman/pkg' >> $CUSTOM
echo 'CacheDir = /var/cache/pacman/custom' >> $CUSTOM
echo 'CleanMethod = KeepCurrent' >> $CUSTOM
echo '[custom]' >> $CUSTOM
echo 'SigLevel = Optional TrustAll' >> $CUSTOM
echo 'Server = file:///var/cache/pacman/custom' >> $CUSTOM
echo 'Include = /etc/pacman.d/custom' >> /etc/pacman.conf
install -d /var/cache/pacman/custom -o owpk
repo-add /var/cache/pacman/custom/custom.db.tar
pacman -Syu
