#!/bin/sh -x
#ARCH post-install script

echo "Main user"
read MAINUSER

echo "Hostname (no whitespace):"
read HOSTNAME


CMD="ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime"
read && $CMD

CMD="hwclock --systohc"
read && $CMD

cp /etc/locale.gen /etc/locale.gen.bak

CMD="sed -E 's/^#(en_US.UTF-8 UTF-8  )$/\1/g' /etc/locale.gen.bak > /etc/locale.gen"
read && eval "$CMD"

grep -A3 -B3 'en_US.UTF-8' /etc/locale.gen

CMD="locale-gen"
read && $CMD

CMD="echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
read && eval "$CMD"

CMD="echo $HOSTNAME > /etc/hostname"
read && eval "$CMD"

echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1	localhost' >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

cat /etc/hosts

CMD="passwd"
read && $CMD

CMD="pacman -Syyu grub nano vi vim networkmanager sudo man gpm rsync openssh pacman-contrib pacutils base-devel git reflector"
read && $CMD

lsblk

echo "Extra flags to grub install (e.g.: --removable):"
read GRUBEXTRA

CMD="grub-install --target=x86_64-efi --efi-directory /boot --boot-directory /boot $GRUBEXTRA"
read && $CMD

CMD="sed --in-place '/^GRUB_CMDLINE_LINUX_DEFAULT/s/ quiet//' /etc/default/grub"
read && eval $CMD

CMD="grub-mkconfig -o /boot/grub/grub.cfg"
read && $CMD

CMD="systemctl enable NetworkManager"
read && $CMD


CMD="echo '%wheel ALL=(ALL) ALL' >> /etc/sudoers"
read && eval "$CMD"

CMD="visudo -c -f /etc/sudoers"
read && $CMD

CMD="useradd -m -G wheel $MAINUSER"
read && $CMD

CMD="passwd $MAINUSER"
read && $CMD
