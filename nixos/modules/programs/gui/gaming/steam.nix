{ lib, config, pkgs, ... }:
let
  inherit (lib) mkIf mkEnableOption;
in
{
    options.modules.programs.gui.gaming.steam = {
        enable = mkEnableOption "Steam, Valve game distribution platform";
    };

    config = lib.mkIf config.modules.programs.gui.gaming.steam.enable {
      programs.steam = {
        enable = true;

        package = pkgs.steam.override {
          extraPkgs = pkgs': with pkgs'; [
            libxcursor
            libxi
            libxinerama
            libxscrnsaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
          ];
        };
      };
    };
}