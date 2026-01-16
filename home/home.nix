{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./desktop-environment.nix
    ./modules
  ];

  # System settings
  home.stateVersion = "25.05"; # TODO check if correct

  programs = {
    # Essentials
    git = {
      enable = true;
      settings = {
        user.email = "nekotori55@gmail.com";
        user.name = "nekotori55";
      };
      lfs.enable = true;

      ignores = [
        ".direnv/"
        ".envrc"
      ];
    };

    helix = {
      enable = true;
      defaultEditor = true;

      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt-rfc-style";
          language-servers = [
            "nixd"
            "nil"
          ];
        }

        {
          name = "markdown";
          auto-format = true;
          language-servers = [
            "marksman"
            "mpls"
          ];
        }
      ];

      languages.language-server.mpls = {
        command = "mpls";
        args = [
          "--dark-mode"
        ];
        # An example args entry showing how to specify flags with values:
        # args = ["--port", "8080", "--browser", "google-chrome", "--theme", "gruvbox-dark"]
      };

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
        config = "cd ~/.config/nixos; hx ./flake.nix";
        conf = "config";
        home = "cd ~/.config/nixos/home; hx ./home.nix";

        dev = "nix develop";
        flakeparts-init = "nix flake init -t github:hercules-ci/flake-parts";
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      silent = true;
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

    # Nix LSP
    nil
    nixd
    nixfmt-rfc-style

    # Markdown LSP
    marksman
    mpls

    # Useful
    bitwarden-desktop
  ];
}
