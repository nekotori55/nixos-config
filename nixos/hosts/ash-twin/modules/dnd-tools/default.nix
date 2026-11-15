{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.modules.dnd-tools = {
    enable = lib.mkEnableOption "dnd stuff";
  };

  config = lib.mkIf config.modules.dnd-tools.enable {
    environment.systemPackages = [
      pkgs.wonderdraft
      (pkgs.callPackage ./dungeondraft.nix { })
    ];
  };
}
