{ lib, profile, ... }:
let
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) bool str enum;
in
{
  options.modules.meta = {
    username = mkOption {
      type = str;
      default = "nekotori55";
      description = "Option to change default username";
    };

    # TODO: Move from meta
    profile = mkOption {
      type = enum [
        "workstation"
        "server"
      ];
      default = profile;
      readOnly = true;
      description = "Helper read-only option with current profile";
    };

    headless = mkOption {
      type = bool;
      default = (profile == "server");
      readOnly = true;
      description = "True, if system runs without GUI";
    };

    isVmVariant = mkEnableOption "True, if system is vmVariant (nixos-rebuild build-vm)";
  };

  config = {
    virtualisation.vmVariant = {
      modules.meta.isVmVariant = true;
    };
  };
}
