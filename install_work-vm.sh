#!/bin/sh


Help()
{
   # Display Help
   echo "An attempt of somewhat automatic installer."
   echo
   echo "Syntax: install.sh "
}


if [ $? != 0 ] ; echo "Terminating..." ; exit 1 ;

HOST=
UEFI=true
DISK=sda
USER=nekotori55

while true; do
  case "$1" in
    -u | --uefi ) UEFI=true; shift ;;
    -h | --host ) HOST="$2"; shift 2 ;;
    -d | --disk ) DISK="$2"; shift 2 ;;
    -h | --help ) exit 0 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

if [ -z "${HOST}" ] 
then
    echo "Hostname is required!"
    exit -1;
fi 


if [ "$UEFI" = true ]
then
    echo "creating GPT partition table"
    parted /dev/$DISK -- mklabel gpt

    echo "adding root partition"
    parted /dev/$DISK -- mkpart root ext4 512MB 100%

    echo "adding boot partition"
    parted /dev/$DISK -- mkpart ESP fat32 1MB 512MB
    parted /dev/$DISK -- set 2 esp on

    echo "initialising boot partition (UEFI)"
    mkfs.fat -F 32 -n boot /dev/$DISK3

else # DOS

    echo "creating MBR partition table"
    parted /dev/$DISK -- mklabel msdos

    echo "adding root partition"
    parted /dev/$DISK -- mkpart primary 1MB 100%

    echo "setting root partition as the boot one"
    parted /dev/$DISK -- set 1 boot on
fi

    echo "initialising nixos partition with ext4 on $DISK1"
    mkfs.ext4 -L nixos /dev/$DISK1

    echo "mounting target partitions"
    mount /dev/disk/by-label/nixos /mnt

if [ "$UEFI" = true ]
then

    echo "mounting boot (UEFI)"
    mkdir -p /mnt/boot
    mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
fi

echo "cloning config from github.com/nekotori55/nixos-config"
git clone https://github.com/nekotori55/nixos-config.git /mnt/etc/nixos

echo "Installing nixos"
nixos-install --no-root-passwd --flake /mnt/etc/nixos#$HOSTNAME

echo "Post install sequence"
# POST INSTALL
nixos-enter --root /mnt -c 

mkdir -p /home/$USER/.config/nixos
mv /etc/nixos/ .config/ -r
chown 1000 -r /home/$USER/.config/nixos
rm /etc/nixos -rf
ln -sf /home/$USER/.config/nixos /etc/nixos