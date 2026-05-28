{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      kdePackages.dolphin
      kdePackages.dolphin-plugins
    ];

    ricing-mode.files."dolphinrc".source = ./dolphinrc;
  };
}
