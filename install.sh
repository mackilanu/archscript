#!/bin/bash

#Configure system

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/mackilanu/dot.git

sudo ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

sudo hwclock --systohc

sudo cp  /etc/locale.gen /etc/locale.gen.backup
sudo sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

sudo locale-gen

sudo mv ~/dot/locale.conf /etc/locale.conf

sudo mv ~/dot/vconsole.conf /etc/vconsole.conf

sudo mv  ~/dot/hostname /etc/hostname

sudo mv ~/dot/login /etc/pam.d

#Installing grub
sudo pacman -S grub efibootmgr os-prober

sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg


#Install yay
echo Installing yay...
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd ~/yay
makepkg -si
cd ~
rm -rf yay/

#Creating standard dirs
mkdir Pictures
mkdir Videos
mkdir Music
mkdir Documents
mkdir Templates

#Install vim and it's configuration
echo Installing vim config...
sudo pacman -S vim git
mkdir -vp ~/.vim/bundle
mv ~/dot/.vimrc ~/.vimrc

#Install i3 and configuring it...
echo Installing i3 and configuring...
sudo pacman -S i3-gaps i3status i3lock i3status rofi picom network-manager-applet blueman blueman feh xorg xorg-xinit dunst firefox linux-lts reflector
mkdir -pv ~/.config/i3
mv ~/dot/i3_config ~/.config/i3/config
sudo mv ~/dot/picom_config /etc/xdg/picom.conf
mv ~/dot/bg.jpg ~/Pictures
mv ~/dot/.xinitrc ~

mv ~/dot/.Xresources ~

#Configuring reflector
echo Configuring reflector...
mkdir -p /etc/xdg/reflector
mv ~/dot/reflector.conf /etc/xdg/reflector

#Configure terminator
echo Installing terminator and configuring it
sudo pacman -S terminator
mkdir ~/.config/terminator
mv ~/dot/terminator_config ~/config/terminator/config

#Configure bashrc
mv ~/dot/.bashrc ~

echo Enabling some systemd stuff..
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable reflector --now

#Configure grub
echo Configuring grub...
sudo mv ~/dot/grub /etc/default
tar -xf ~/dot/Vimix.tar
cd Vimix-1080p/
sudo ./install.sh

echo All done! Restart, login and run startx!
