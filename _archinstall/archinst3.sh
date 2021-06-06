#!/bin/sh -x
#ARCH post-install script


CMD="sudo pacman -S xorg-server gnome-shell gnome-control-center gdm terminator nautilus nvidia"
read && $CMD

CMD="sudo sed --in-place '/^#WaylandEnable/s/^#//' /etc/gdm/custom.conf"
read && eval $CMD

grep -A 3 -B 3 WaylandEnable /etc/gdm/custom.conf

CMD="sudo systemctl enable gdm"
read && $CMD

echo Install pamac...
read

cd ~
git clone https://aur.archlinux.org/pamac-aur.git
cd pamac-aur
makepkg -csir
cd ..
rm -rf pamac-aur

CMD="sudo sed --in-place 's/#EnableAUR/EnableAUR/' /etc/pamac.conf"
read && eval $CMD

CMD="sudo sed --in-place 's/#CheckAURUpdates/CheckAURUpdates/' /etc/pamac.conf"
read && eval $CMD

sudo grep -A 1 -B 1 AUR /etc/pamac.conf

CMD="pamac update"
read && $CMD

CMD="pamac install google-chrome chrome-gnome-shell"
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

CMD="pamac install optimus-manager optimus-manager-qt gdm-prime"
read && $CMD

CMD="sudo pacman -S wget mc htop xdg-user-dirs gnome-screenshot hexchat paprefs pavucontrol mpv bash-completion coreutils docker doublecmd-gtk2 baobab gnome-font-viewer gparted meld calc gnome-calculator breeze-icons kolourpaint drawing"
read && $CMD

CMD="pamac install icaclient hdx-realtime-media-engine teamviewer zoom skypeforlinux-stable-bin"
read && $CMD

CMD="grep -A 3 -B 3 WaylandEnable /etc/gdm/custom.conf"
read && $CMD

# text viewer
