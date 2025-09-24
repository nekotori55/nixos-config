{
  pkgs,
  osConfig,
  ...
}:
{
  imports = [
    ./desktop/bspwm
    ./desktop/hyprland
    ./desktop/themes
    ./apps
  ];

  home = {
    packages = with pkgs; [
      # TODO move to hyprland section?
      fuzzel
      grim
      slurp
      wl-clipboard
    ];

    stateVersion = osConfig.system.stateVersion;
  };

  services.git-sync.enable = true;
  services.git-sync.repositories =
    let
      homePath = osConfig.modules.home.dir;
    in
    {
      wallpapers1 = {
        path = "${homePath}/wallpapers";
        uri = "git@github.com:nekotori55/wallpapers.git";
        interval = 60;
        extraPackages = with pkgs; [ git-lfs ];
      };

      studies-7 = {
        path = "${homePath}/vault/studies-7";
        uri = "git@github.com:nekotori55/studies-7.git";
        interval = 60;
      };
    };
}
