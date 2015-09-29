# arch uefi dm-crypt zfsroot install (archiso)

# partition disk
# start at 1MB (sector 2048)
512Mib EFI
512Mib Boot
Rest ZFS

#setup encrypted partition
cryptsetup luksFormat -l 512 -c aes-xts-plain64 -h sha512 /dev/disk/by-partuuid/<uid>
cryptsetup luksOpen /dev/disk/by-partuuid/<uid> cryptroot

# set architecture to x86_64
# and
# add unofficial archzfs repo
# edit /etc/pacman.conf
Architecture = x86_64

[demz-repo-archiso]
Server = http://demizerone.com/$repo/$arch

# edit /etc/pacman.d/mirrorlist to get only your nearest mirrors

# setup networking

# set nameserver
# edit /etc/resolve.conf
nameserver <ip>


# add keys ofr demiz repo
pacman-key -r 0ee7a126
pacman-key --lsign-key 0ee7a126

# update package index
pacman -Syy

# install archzfs
# default: all
pacman -S archzfs-git

# zfs setup
touch /etc/zfs/zpool.cache

#setup ZFS (ashift for modern drives, ssd)
zpool create -f -o ashift=12 -o cachefile=/etc/zfs/zpool.cache -O normalization=formD -m none -R /mnt rpool /dev/mapper/cryptroot

zfs create -o mountpoint=none -o compression=lz4 rpool/ROOT

#rootfs
# DONT'T CREATE extra /usr on arch, see here:
#  - http://freedesktop.org/wiki/Software/systemd/separate-usr-is-broken/
#  - https://wiki.archlinux.org/index.php/Mkinitcpio
zfs create -o mountpoint=/ rpool/ROOT/rootfs
zfs create -o mountpoint=/opt rpool/ROOT/rootfs/OPT

#homedirs
zfs create -o mountpoint=/home rpool/HOME
zfs create -o mountpoint=/root rpool/HOME/root

##zpool set bootfs=rpool rpool

# export and reimport pool, so you don't need to force next import
zpool export rpool
zpool import -R /mnt rpool

# mount boot partitions
mkdir /mnt/boot
mount /dev/disk/by-partuuid/<uid> /mnt/boot
mkdir /mnt/boot/efi
mount /dev/disk/by-partuuid/<uid> /mnt/boot/efi

# install base system
pacstrap -i /mnt base base-devel

# create fstab
genfstab -U -p /mnt | grep boot >> /mnt/etc/fstab

# chroot into installation
arch-chroot /mnt /bin/bash

# set locale
# edit /etc/locale.gen
en_US.UTF-8 UTF-8
de_DE.UTF-8 UTF-8

# generate locale
locale-gen

# set default language
echo LANG=de_DE.UTF-8 > /etc/locale.conf

# set timezone
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# set hardware clock
hwclock --systohc --utc

# install ntp
pacman -S ntp

# add country pools to conf
# nano /etc/ntp.conf

# sync time
ntpd -q

# save to hardware clock
hwclock -w

# set keymap and font
loadkeys de

# and
# add unofficial archzfs repo
# edit /etc/pacman.conf
Architecture = x86_64

[demz-repo-core]
Server = http://demizerone.com/$repo/$arch

# add keys ofr demiz repo
pacman-key -r 0ee7a126
pacman-key --lsign-key 0ee7a126

# edit /etc/pacman.d/mirrorlist

# update package database
pacman -Syy
pacman -Su --ignore filesystem,bash
pacman -S zsh
pacman -Su

# install other needed packages
pacman -S gnupg vim archzfs-git

# enable zfs automount
systemctl enable zfs.service

# add hooks for initramfs
# edit /etc/mkinitcpio.conf
#
# HOOKS=... keyboard before encrypt before zfs before filesystems. No fsck.
# MODULES="dm_mod"

# make initramfs
mkinitcpio -p linux

# set root password
passwd

# set hostname
echo <name> > /etc/hostname

# edit HOOKS in /etc/mkinitcpio.conf
keyboard before encrypt befor zfs befor filesystems NO fsck

# edit /etc/defaults/grub
GRUB_CMDLINE_LINUX_DEFAULT="cryptdevice=/dev/sda3:cryptroot zfs=rpool/ROOT/rootfs"

mkinitcpio -p linux

# !!grub-mkconfig is fucked when using zfs.
grub-install --recheck /dev/sda

# add configs to grub menu

menuentry "Arch Linux" {
   set root=(hd0,msdos1)
   linux /vmlinuz-linux root=/dev/mapper/cryptroot zfs=rpool/ROOT/rootfs cryptdevice=/dev/sda3:cryptroot boot=zfs rw
   initrd /initramfs-linux.img

}


# Installation is finished
exit
umount /mnt/boot
zfs umount -a

# export zfs
zpool export rpool

# reboot
