{ config, lib, ... }:
{
  options.modules.shell.git.enable = lib.mkEnableOption "Enable git";

  config = lib.mkIf config.modules.shell.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user.email = "nekotori55@gmail.com";
        user.name = "nekotori55";

        alias = {
          hide = "update-index --assume-unchanged";
          unhide = "update-index --no-assume-unchanged";
        };
      };
      lfs.enable = true;
    };

    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
