{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  commonExtensions =
    with pkgs.vscode-extensions;
    [
      bbenoist.nix
      jnoortheen.nix-ide
      leonardssh.vscord
      tobiasalthoff.atom-material-theme
      emroussel.atomize-atom-one-dark-theme
      mkhl.direnv
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];

  commonSettings = {

    # EDITOR SETTINGS
    "editor.formatOnSave" = true;
    "window.restoreWindows" = "none";
    "git.enableSmartCommit" = true;
    "git.confirmSync" = false;
    "explorer.confirmDelete" = false;
    "extensions.ignoreRecommendations" = true;
    "editor.minimap.enabled" = false;
    "window.menuBarVisibility" = "toggle";
    "workbench.tree.indent" = 12;
    "workbench.tree.renderIndentGuides" = "always";

    # bash has this weird symbols idk whats broken so i just will use fish there
    "terminal.integrated.defaultProfile.linux" = "fish";

    "workbench.colorTheme" = "Atomize";

    # VSCORD
    "vscord.behaviour.suppressNotifications" = false;

    # NIX
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "nix.serverSettings" = {
      "nixd" = {
        "formatting" = {
          "command" = "nixfmt";
        };
        "options" = {
          "enable" = true;
        };
      };
    };

    # "python.defaultInterpreterPath" = "\${env:PYTHONPATH}";
    # "auto-run-command.rules" = [
    #   {
    #     "condition" = [ "always" ];
    #     "command" = "python.clearWorkspaceInterpreter";
    #     "message" = "Super condition met. Running";
    #   }
    # ];

    "direnv.restart.automatic" = true;
  };
in
{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];

  programs.bash = {
    enable = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
    silent = false;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    #userSettings = commonSettings;
    #extensions = commonExtensions;

    #enableUpdateCheck = false;
    #enableExtensionUpdateCheck = false;

    profiles = {
      default = {
        extensions = commonExtensions;
        userSettings = commonSettings;
      };

      flutter = {
        extensions = with pkgs.vscode-extensions; [ dart-code.flutter ] ++ commonExtensions;
        userSettings = commonSettings;
      };
    };

    #mutableExtensionsDir = false;
  };
}
