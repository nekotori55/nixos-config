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

    programs.gamescope = mkIf cfg.gamescope {
      enable = true;
      # capSysNice = true;
      args = [
        # "--rt"
        "-w 1920 -h 1080"
        "-W 1920 -H 1080"
        "-r 144"
        "-S integer"
        "--prefer-vk-device 10de:1f91"
        "-F nearest"
        "--sharpness 0"
        "-f"
      ];
    };

    services.ananicy = mkIf cfg.gamescope {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp;
      extraRules = [
        {
          "name" = "gamescope";
          "nice" = -18;
        }
      ];
    };

    programs.gamemode.enable = true;

    environment.systemPackages =
      with pkgs;
      [
      ]
      ++ optional cfg.minecraft prismlauncher
      ++ optional cfg.osu osu-lazer-bin;
  };
}
