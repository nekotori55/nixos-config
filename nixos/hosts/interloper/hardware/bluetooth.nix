{ ... }:
{
  hardware.bluetooth = {
    enable = true;
  };

  # boot.extraModprobeConfig = ''
  #   options btusb autosuspend=0
  # '';
}
