#!/bin/bash
set -e

if [ -d "$HOME/dotfiles-swayfx" ]; then
   mv $HOME/dotfiles-swayfx $HOME/dotfiles-swayfx.bak 2> /dev/null
fi

cd $HOME
git clone --depth 1 https://github.com/owpk/dotfiles-swayfx
cd $HOME/dotfiles-swayfx
DOT=$(pwd)

# install terminal utils
git submodule update --init --recursive
TERM_UTILS="server-dots"

git config user.name "$USER"
git config user.email "--auto--"

curl -Ls https://raw.githubusercontent.com/owpk/dots-misc/refs/heads/main/install-deps.sh | bash -s -- $DOT/deps

CFG=$HOME/.config
LOCAL_BIN=$HOME/.local/bin
mkdir -p $LOCAL_BIN 2> /dev/null
mkdir -p $CFG 2> /dev/null

function prepareBackups() {
   echo "Creating backup..."
   BACKUP_DIR="$HOME/dotfiles-backups"
   mkdir -p $BACKUP_DIR/.config 2> /dev/null
   
   TR=$(ls $DOT/.config)

   for filename in $TR; do
      echo "Processing backup for file: $filename"
      echo "MV: $CFG/$filename -> $BACKUP_DIR/.config"
      mv $CFG/$filename $BACKUP_DIR/.config
   done

   mv $HOME/.themes $BACKUP_DIR/
}

prepareBackups

stow --adopt -vt $CFG .config
stow --adopt -vt $LOCAL_BIN scripts 

sudo mkdir -p /usr/share/fonts/TTF 2> /dev/null
sudo cp ./fonts/* /usr/share/fonts/TTF/
fc-cache

ln -nsf $(pwd)/.themes $HOME/

git checkout -b "$USER"

cd $TERM_UTILS
./install.sh

sleep 2

sudo curl -L https://github.com/owpk/sway-keyhints/releases/latest/download/swaykeyhints --output /usr/bin/swaykehints
sudo chmod +x /usr/bin/swaykehints

echo " ::KEYBINDINGS:: "
/usr/bin/swaykehints -h 100 -w 200

echo "All done! Please check current keybindings above"
echo "Use '/usr/bin/swaykehints' for keybindings help"
echo "Your backup files created at: $BACKUP_DIR"
