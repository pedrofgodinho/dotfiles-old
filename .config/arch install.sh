#!/bin/bash

sudo pacman -S xorg xorg-xinit lightdm noto-fonts noto-fonts-emoji lightdm-slick-greeter bspwm sxhkd zsh pulseaudio pulseaudio-alsa pavucontrol kitty dmenu xbindkeys light feh picom polkit mate-polkit neovim xclip python python2 python-pynvim nodejs npm firefox tree unzip p7zip neofetch wget lolcat fortune-mod cowsay vlc

yay -S lightdm-slick-greeter lf-bin bottom-bin python2-nvim

# keeping this line to remind myself to do it
# sudo localectl set-x11-keymap pt

sudo sed -i '/^\[Seat:\*]/a user-session=bspwm' /etc/lightdm/lightdm.conf
sudo sed -i '/^\[Seat:\*]/a greeter-session=lightdm-slick-greeter' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm.service

# https://www.reddit.com/r/nordtheme/comments/hxldpu/nordic_obsession/
sudo wget https://i.imgur.com/shyNwsK.png -O /usr/share/pixmaps/wallpaper.jpg

sudo echo "[Greeter]" > /etc/lightdm/slick-greeter.conf
sudo echo "background=/usr/share/pixmaps/wallpaper.jpg" >> /etc/lightdm/slick-greeter.conf

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

mkdir -p ~/.local/share/fonts
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O "~/.local/share/fonts/MesloLGS NF Regular.ttf"
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O "~/.local/share/fonts/MesloLGS NF Bold.ttf"
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O "~/.local/share/fonts/MesloLGS NF Italic.ttf"
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O "~/.local/share/fonts/MesloLGS NF Bold Italic.ttf"
fc-cache -f -v

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# Download dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
echo ".dotfiles" > .gitignore
git clone --bare https://github.com/Fowlron/bspwm-dotfiles.git $HOME/.dotfiles
dotfiles stash
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

# TODO polybar
# TODO kitty keybinds