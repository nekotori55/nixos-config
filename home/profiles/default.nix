{
  osConfig,
  lib,
  pkgs,
  ...
}:
let
  host-profile = osConfig.modules.profiles.profile;

  is-workstation = host-profile == "workstation";
  is-server = host-profile == "server";

  ####
  archiving-utils = with pkgs; [
    zip
    unzip
    rar
  ];

in
{
  config = lib.mkMerge [
    (lib.optionalAttrs is-server {
      modules = {

        shell = {
          helix.enable = true;
          git.enable = true;
        };

      };

      home.packages =
        with pkgs;
        [
          btop
          scooter
        ]
        ++ archiving-utils;
    })

    (lib.optionalAttrs is-workstation {
      modules = {
        programs = {
          firefox.enable = true;
          discord.enable = true;
          kitty.enable = true;
        };

        shell = {
          aliases.enable = true;
          git.enable = true;
          starship.enable = true;
          direnv.enable = true;
          helix.enable = true;
        };

      };

      home.packages =
        with pkgs;
        [
          # koreader # book reading

          # Social #
          #
          telegram-desktop

          # Editors #
          #
          # blender
          godot
          # reaper
          obsidian
          # krita
          vscode-fhs

          # Games #
          #
          # kdePackages.kmines

          # Utility #
          #
          # filezilla
          obs-studio
          qbittorrent
          btop
          scooter # find and replace tool

          # Web Browsers #
          #
          ungoogled-chromium

        ]
        ++ archiving-utils;
    })
  ];
}
