{ ... }:
{
  hardware.bluetooth = {
    enable = true;

    # settings = {
    # General = {
    # Enable = "Source,Sink,Media,Socket";
    # };
    # };
  };

  boot.extraModprobeConfig = ''
    options btusb autosuspend=0
  '';
}
