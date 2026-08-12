{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.modules.programs.gui.gaming.minecraft = {
    enable = mkEnableOption "Minecraft";
  };

  config = mkIf config.modules.programs.gui.gaming.minecraft.enable {
    environment.systemPackages = [
      pkgs.prismlauncher
    ];
  };
}
