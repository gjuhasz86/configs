#!/bin/sh -x
#ARCH post-install script


CMD="sudo pacman -S xorg-server gnome-shell gnome-control-center gdm terminator nautilus nvidia"
read && $CMD

CMD="sudo sed --in-place '/^#WaylandEnable/s/^#//' /etc/gdm/custom.conf"
read && eval $CMD

grep -A 3 -B 3 WaylandEnable /etc/gdm/custom.conf

CMD="sudo systemctl enable gdm"
read && $CMD

echo Install yay...
read

cd ~
git clone https://aur.archlinux.org/yay
cd yay
makepkg -csir
cd ..
rm -rf yay

CMD="yay -S google-chrome chrome-gnome-shell"
read && $CMD

# echo Install liveroot...
# read

# cd ~
# git clone https://aur.archlinux.org/liveroot.git
# cd liveroot
# sed --in-place 's/bluerider/nonlinear-labs-dev/' PKGBUILD
# sed --in-place 's/bluerider/nonlinear-labs-dev/' .SRCINFO
# sed --in-place 's/1.0/master/' PKGBUILD
# sed --in-place 's/1.0/master/' .SRCINFO
# sed --in-place 's/652b01fdfa45a97f35a9ec52b11cb229efd7552ebee88a4c429edff33c4d501b/ad63f28b73735b938381e428ad1ccd245a4706c5e7994d53512542f3d4e3b929/' PKGBUILD
# sed --in-place 's/652b01fdfa45a97f35a9ec52b11cb229efd7552ebee88a4c429edff33c4d501b/ad63f28b73735b938381e428ad1ccd245a4706c5e7994d53512542f3d4e3b929/' .SRCINFO

# makepkg -csir
# cd ..

# sudo sed --in-place '/^HOOKS/s/udev/udev oroot/' /etc/mkinitcpio.conf
# sudo sed --in-place '/^MODULES/s/)/ zram overlay)/' /etc/mkinitcpio.conf
# sudo mkinitcpio -p linux

CMD="yay -S optimus-manager optimus-manager-qt gdm-prime"
read && $CMD

CMD="sudo pacman -S wget mc htop xdg-user-dirs gnome-screenshot hexchat paprefs pavucontrol mpv bash-completion coreutils docker doublecmd-gtk2 baobab gnome-font-viewer gparted meld calc gnome-calculator breeze-icons kolourpaint drawing ttf-dejavu gnome-tweaks"
read && $CMD

CMD="yay -S icaclient hdx-realtime-media-engine teamviewer zoom skypeforlinux-stable-bin"
read && $CMD

CMD="sudo sed --in-place '/^#WaylandEnable/s/^#//' /etc/gdm/custom.conf"
read && eval $CMD

CMD="grep -A 3 -B 3 WaylandEnable /etc/gdm/custom.conf"
read && $CMD


# Install a virtual machine

CMD="sudo pacman -S qemu virt-manager"
read && $CMD

CMD="sudo systemctl start libvirtd.service"
read && $CMD

# Install Nix

CMD="yay -S nix archlinux-nix"
read && $CMD

CMD="sudo archlinux-nix setup-build-group && sudo archlinux-nix bootstrap"
read && eval $CMD

CMD="sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable && sudo nix-channel --update && nix-env -u"
read && eval $CMD