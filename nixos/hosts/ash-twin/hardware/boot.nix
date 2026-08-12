{ ... }:
{
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      gfxmodeEfi = "1920x1080";
    };
    efi.canTouchEfiVariables = true;
  };
}
