{ config, lib, ... }:
let
  inherit (lib) mkIf mkDefault;
  bluetoothEnabled = config.hardware.bluetooth.enable;
in
{
  config = mkIf (config.modules.profiles.profile == "workstation") {
    services.pipewire.wireplumber.extraConfig = mkIf bluetoothEnabled {
      "11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };

    # services.blueman.enable = mkDefault bluetoothEnabled;

    # Enable USB automount
    services.udisks2.enable = mkDefault true;
  };
}
