{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption;
  inherit (lib) mkIf;

  gaming = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Install gaming packages, apply tweaks";

    steam = mkEnableOption "";
    minecraft = mkEnableOption "Install Prism Minecraft Launcher";
    gamescope = mkEnableOption "Install Valve compositor gamescope";
  };

  config = mkIf gaming.enable {
    programs.steam = mkIf gaming.steam {
      enable = true;
    };

    programs.gamescope = mkIf gaming.gamescope {
      enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
      ]
      ++ lib.optional gaming.minecraft prismlauncher;
  };
}
