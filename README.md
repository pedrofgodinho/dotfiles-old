# My dotfiles
This repository contains my setup's dotfiles.
Some directory names are hard-coded into some dotfiles, so make sure you check each file before downloading them!

# Instalation
In this section I'll be detailing exactly how I installed my system. A lot of this will not be applicable to everyone, I'm writing it mostly as a note to myself for future reference.

## Arch Install
    #Load keyboard layout
    loadkeys pt-latin1
    
    #Connect to the internet
    wifi-menu
    
    #Setup timedatectl
    timedatectl set-ntp true
    
    #Partition the disk
    cfdisk
    mkfs.ext4 /dev/sda3
    mkswap /dev/sda4
    swapon /dev/sda4
    
    #Pacstrap
    mount /dev/sda3 /mnt
    pacstrap /mnt base base-devel linux linux-firmware vim man-db man-pages texinfo dhcpcd wpa_supplicant dialog netctl
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt

Once chrooted into the new installation:

    #Setup time
    ln -sf /usr/share/zoneinfo/Portugal /etc/localtime
    hwclock --systohc
    
    #Uncomment the needed locales (in my case, en_US.UTF-8 and pt_PT.UTF-8)
    vim /etc/locale.gen
    locale-gen
    #Add LANG=en_US.UTF-8 to locale.conf
    vim /etc/locale.conf
    #Add KEYMAP=pt-latin1 to vconsole.conf
    vim /etc/vconsole.conf
    
    #Setup hostname and hosts file as detailed in the arch wiki installation guide
    vim /etc/hostname
    vim /etc/hosts
    
    #Set root password
    passwd
    
    #Install grub, with os-prober for dual-boot
    pacman -S grub efibootmgr os-prober
    #Mount the EFI partition
    mkdir /boot/efi
    mount /dev/sdb1 /boot/efi
    #Mount the other OS partition for os-prober to find it
    mount /dev/sdb3 /mnt
    #Install grub
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
    #Change grub settings. In my case, I made grub remember the last choice. I also needed to add 'acpi_osi=! acpi_osi=\"Windows 2013\"' after quiet in GRUB_CMDLINE_LINUX_DEFAULT="quiet" for some hardware to work properly
    vim /etc/default/grub 
    grub-mkconfig -o /boot/grub/grub.cfg
    
    # Installation is done, we can reboot into the installed system
    reboot

On the installed system, we now add the sudo user:

    #Connect to the internet
    wifi-menu
    
    #Install sudo
    pacman -S sudo
    #Add the sudo group
    groupadd sudo
    #Add the user (-m to create home directory, -G to add to groups, -s to select shell)
    useradd -m -G sudo wheel -s /bin/bash pedro
    #Set user password
    passwd pedro

Sort pacman mirrors (maybe I should've done this earlier):

    #pacman-contrib for rankmirrors
    pacman -S pacman-contrib
    
    #get the top 12 mirrors
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
    rankmirrors -n 12 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
    
    #Uncomment multilib on pacman config
    #I also added colors and the ILoveCandy easter egg
    vim /etc/pacman.conf
	
	#Exit and login as the new user
	exit

Install yay for AUR management:

    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay

Install the graphical environment and the things needed for my dotfiles to work:

    # I selected noto fonts when asked
    yay -S xorg xorg-xinit lightdm lightdm-slick-greeter i3-gaps kitty
    # Change [Seat:*] to set greeter to lightdm-slick-greeter
    sudo vim /etc/lightdm/lightdm.conf
    sudo systemctl enable lightdm.service
    # Set the kayboard layout
    sudo localectl set-x11-keymap pt
    
    # Applications that i3 launches
    # pillow is needed for ranger to show images
    sudo pacman -S firefox ranger pcmanfm python python-pillow dmenu
    
    # Some other useful tools I use often
    sudo pacman -S unzip p7zip tree neofetch wget lolcat fortune-mod cowsay cava
    yay -S ytop
    
    # Wallpaper rotation
    sudo pacman -S feh imagemagick
    
    # Correct natural scrolling
    # Add Option "Natural Scrolling" "true" under the touchpad section
    sudo vim /usr/share/X11/xorg.conf.d/40-libinput.conf
    
    # Install adi1090x's polybar theme 7
    sudo pacman -S wireless_tools, light
    yay -S polybar
    
    # xbindkeys for fn keys
    sudo pacman -S xbindkeys
    
    # Picom for transparency
    sudo pacman -S picom
    
    # pulseaudio setup
    sudo pacman -S pulseaudio pulseaudio-alsa

Install zsh and oh-my-zsh

    sudo pacman -S zsh
    #Download oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    
    #Download the zsh extensions I use
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

Setup fstab to auto mount the windows partition:

    #To automount a windows partition and link it to our user folder:
    sudo pacman -S ntfs-3g
    sudo mkdir /windows_shared
    ln -s /windows_shared ~/shared
    
    # add to fstab
    # UUID=replace_with_partition_uuid	/windows_shared	ntfs-3g		defaults,dmask=027,umask=137,uuid=1000,gid=1000	0 0
    sudo vim /etc/fstab

Setup neovim:

    sudo pacman -S neovim
    
    # Install vim-plug
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
    # CoC dependencies
    sudo pacman -S nodejs npm
    
    # Open vim and execute :PlugInstall to install the plugins
    # Open vim and execute :PlugUpdate to update plugins
    # Open vim and execute :CocInstall coc-pairs to install the pair autocomplete plugin

Install stuff for music:

    sudo pacman -S mpd ncmpcpp
    systemctl --user enable mpd.service

Theme lightdm:

    yay -S lightdm-settings
    sudo cp ~/.wallpaper/wallpaper1.jpeg /usr/share/pixmap/wallpaper1.jpeg
    # Change background
    sudo lightdm-settings

This is all I've done so far to make my system what it is. Following along (adapted to your own seutp) and downloading my dotfiles should leave you with a clone of my own system. Good luck!
