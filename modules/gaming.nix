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
      package = pkgs.steam.override {
        extraPkgs =
          pkgs': with pkgs'; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
          ];
      };
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
