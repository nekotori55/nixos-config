{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib) optional;

  cfg = config.modules.gaming;
in
{
  options.modules.gaming = {
    enable = mkEnableOption "Install gaming packages, apply tweaks";

    steam = mkEnableOption "Install Steam";
    minecraft = mkEnableOption "Install Prism Minecraft Launcher";
    gamescope = mkEnableOption "Install Valve compositor gamescope";
    osu = mkEnableOption "Install OSU!";
  };

  config = mkIf cfg.enable {
    programs.steam = mkIf cfg.steam {
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

    programs.gamescope = mkIf cfg.gamescope {
      enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
      ]
      ++ optional cfg.minecraft prismlauncher
      ++ optional cfg.osu osu-lazer-bin;
  };
}
