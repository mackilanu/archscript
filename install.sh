#!/bin/bash

#Install yay
echo Installing yay...
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~
cd ~/yay
makepkg -si
cd ~
rm -rf yay/

#Install vim and it's configuration
echo Installing vim config...
sudo pacman -S vim git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim ~
git clone https://github.com/mackilanu/dot.git ~
mv ~/dot/.vimrc ~/.vimrc

#Install i3 and configuring it...
echo Installing i3 and configuring...
sudo pacman -S i3-gaps i3status i3lock i3status rofi picom network-manager-applet blueman-applet blueman feh xorg-xinit dunst firefox
mkdir -v ~/.config/i3
mv ~/dot/i3_config ~/.config/i3/config
sudo mv ~/dot/picom_config /etc/xdg/picom.conf
mv ~/dot/bg.jpg ~/Pictures
mv ~/dot/.xinitrc ~

#Configure terminator
echo Installing terminator and configuring it
sudo pacman -S terminator
mkdir ~/.config/terminator
mv ~/dot/terminator_config ~/config/terminator/config

echo All done! Restart, login and run startx!
