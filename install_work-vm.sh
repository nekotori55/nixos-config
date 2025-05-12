#!/bin/sh

echo "Automatic installer for vm with nixos config"
echo "Disk Size should be 50Gb and EFI should be enabled"

echo "creating GPT partition table"
parted /dev/sda -- mklabel gpt

echo "adding root partition"
parted /dev/sda -- mkpart root ext4 512MB -8GB

echo "adding swap partition"
parted /dev/sda -- mkpart swap linux-swap -8GB 100%

echo "adding boot partition"
parted /dev/sda -- mkpart ESP fat32 1MB 512MB
parted /dev/sda -- set 3 esp on

echo "partition end"

echo "formatting start"

echo "initialising nixos partition with ext4 on sda1"
mkfs.ext4 -L nixos /dev/sda1

echo "initialising swap on sda2"
mkswap -L swap /dev/sda2

echo "initialising boot partition (UEFI)"
mkfs.fat -F 32 -n boot /dev/sda3

echo "mounting target partitions"
mount /dev/disk/by-label/nixos /mnt

echo "mounting boot"
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot

echo "mounting swap"
swapon /dev/sda

git clone https://github.com/nekotori55/nixos-config.git /mnt/etc/nixos

nixos-install --flake /mnt/etc/nixos#work-vm
