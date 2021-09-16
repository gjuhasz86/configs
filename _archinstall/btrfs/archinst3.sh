#!/bin/sh -x
#ARCH post-install script as root after reboot

echo "Main user"
read MAINUSER

CMD="umount /.snapshots"
read && eval "$CMD"

CMD="rmdir /.snapshots"
read && eval "$CMD"

CMD="snapper -c root create-config /"
read && eval "$CMD"

CMD="btrfs su de /.snapshots"
read && eval "$CMD"

CMD="mkdir /.snapshots"
read && eval "$CMD"

CMD="mount /.snapshots"
read && eval "$CMD"

CMD="chmod 750 /.snapshots"
read && eval "$CMD"

CMD="chown :snapviewer /.snapshots"
read && eval "$CMD"

CMD='sed --in-place "/^ALLOW_GROUPS=/s/\"\"/\"snapviewer\"/" /etc/snapper/configs/root'
read && eval $CMD

grep -A3 -B3 '^ALLOW_GROUPS' /etc/snapper/configs/root

CMD="mkdir /etc/pacman.d/hooks && cp 50-bootbackup.hook /etc/pacman.d/hooks"
read && eval "$CMD"

CMD="useradd -m -G wheel aurinst"
read && $CMD

CMD="echo 'aurinst ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
read && eval "$CMD"

CMD="visudo -c -f /etc/sudoers"
read && $CMD


CMD="cd /home/aurinst && sudo -u aurinst git clone https://aur.archlinux.org/yay && cd yay && sudo -u aurinst makepkg -si"
read && eval "$CMD"

CMD="sudo -u aurinst yay -S snap-pac-grub rollback"
read && eval "$CMD"

CMD="userdel -r aurinst"
read && $CMD

CMD="sed --in-place '/aurinst/d' /etc/sudoers"
read && eval $CMD

CMD="visudo -c -f /etc/sudoers"
read && $CMD


cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bak

CMD="sed --in-place -E '/^HOOKS=/s/\)$/ grub-btrfs-overlayfs)/g' /etc/mkinitcpio.conf"
read && eval "$CMD"

grep -A3 -B3 '^HOOKS' /etc/mkinitcpio.conf

CMD="mkinitcpio -p linux"
read && eval "$CMD"
