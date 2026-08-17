{
  hostname,
  lib,
  config,
  ...
}:
let
  home = config.home.homeDirectory;
in
{
  options.modules.settings.xdg.user-dirs = {
    enable = lib.mkEnableOption "user-dirs management";
  };

  config = lib.mkIf config.modules.settings.xdg.user-dirs.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;

      desktop = "${home}/desktop";
      documents = "${home}/documents";
      download = "${home}/downloads";
      music = "${home}/music";
      pictures = "${home}/pictures";
      projects = "${home}/projects";
      publicShare = "${home}/public";
      templates = "${home}/templates";
      videos = "${home}/videos";

      extraConfig = {
        MISC = "${home}/misc";
      };
    };
  };  
}
