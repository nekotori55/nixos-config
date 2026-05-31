{
  boot.initrd = {
    systemd.enable = true;
    availableKernelModules = [
      "virtio"
      "virtio_net"
      "virtio_blk"
      "ata_piix"
      "uhci_hcd"
      "virtio_pci"
      "virtio_scsi"
      "sd_mod"
      "sr_mod"
    ];
  };

  boot.loader = {
    grub = {
      enable = true;
      enableCryptodisk = true;
      efiSupport = false;
    };
  };
}
