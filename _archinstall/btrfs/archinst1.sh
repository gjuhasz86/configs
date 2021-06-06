#!/bin/sh -x
#ARCH install script

# mkdir /tmp/share
# mount -t 9p -o trans=virtio /vmshare /tmp/share
# cd /tmp/share
# ./archinst1.sh

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

#ROOT

CMD="mount /dev/$ROOTPART /mnt"
read && $CMD

CMD="btrfs su cr /mnt/@"
read && $CMD

CMD="btrfs su cr /mnt/@home"
read && $CMD

CMD="btrfs su cr /mnt/@snapshots"
read && $CMD

CMD="btrfs su cr /mnt/@var_log"
read && $CMD

CMD="umount /mnt"
read && $CMD

CMD="mount -o noatime,compress=lzo,space_cache=v2,subvol=@ /dev/$ROOTPART /mnt"
read && $CMD

CMD="mkdir -p /mnt/{home,.snapshots,var/log}"
read && eval "$CMD"

CMD="mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/$ROOTPART /mnt/home"
read && $CMD

CMD="mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/$ROOTPART /mnt/.snapshots"
read && $CMD

CMD="mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log /dev/$ROOTPART /mnt/var/log"
read && $CMD

#BOOT

CMD="mkdir /mnt/boot && mount /dev/$BOOTPART /mnt/boot"
read && eval "$CMD"

#SWAP

CMD="swapon /dev/$SWAPPART"
read && $CMD

lsblk

echo Ranking mirrors for Hungary
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

cp ./archinst2.sh ./archinst3.sh 50-bootbackup.hook /mnt/root

CMD="arch-chroot /mnt"
read && $CMD
