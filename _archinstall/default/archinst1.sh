#!/bin/sh -x
#ARCH install script

# mount -t 9p -o trans=virtio,version=9p2000.L /vmshare /tmp/share

timedatectl status
timedatectl set-ntp true
timedatectl status

read

fdisk -l
lsblk


echo Boot partition:
read BOOTPART

echo Swap partition:
read SWAPPART

echo Root partition:
read ROOTPART

echo Home partition:
read HOMEPART

CMD="mount /dev/$ROOTPART /mnt"
read && $CMD

CMD="mkdir /mnt/boot && mount /dev/$BOOTPART /mnt/boot"
read && eval "$CMD"

CMD="swapon /dev/$SWAPPART"
read && $CMD

CMD="mkdir /mnt/home && mount /dev/$HOMEPART /mnt/home"
read && eval "$CMD"


lsblk

echo Ranking mirrors for HU
COUNTRY=Hungary
read

reflector -c $COUNTRY -a 6 --sort rate --save /etc/pacman.d/mirrorlist

cat /etc/pacman.d/mirrorlist

CMD="pacstrap /mnt base linux linux-firmware"
read && $CMD

genfstab -U /mnt

CMD="genfstab -U /mnt >> /mnt/etc/fstab"
read && eval "$CMD"

cat /mnt/etc/fstab

cp ./archinst2.sh ./archinst3.sh /mnt/root

CMD="arch-chroot /mnt"
read && $CMD
