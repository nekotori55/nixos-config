{ lib, pkgs, ... }:
{
  imports = [
    ./desktop-environment.nix
  ];

  # System settings
  home.stateVersion = "25.05";

  programs = {
    # Essentials
    git = {
      enable = true;
      settings = {
        user.email = "nekotori55@gmail.com";
        user.name = "nekotori55";
      };
      lfs.enable = true;
    };

    helix = {
      enable = true;
      defaultEditor = true;

      languages.language = [
        {
          # TODO LSP
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
      ];

      settings = {
        editor.auto-save = {
          after-delay.enable = true;
          after-delay.timeout = 3000;
          focus-lost = true;
        };
      };
    };

    bash = {
      enable = true;
      shellAliases = {
        config = "cd .config/nixos; nix develop";
        flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";
      };
    };

    firefox = {
      enable = true;
      package = pkgs.librewolf;
      # TODO add extensions and parameters
    };
  };

  home.packages = with pkgs; [
    # Messengers
    telegram-desktop
    ungoogled-chromium
  ];
}
