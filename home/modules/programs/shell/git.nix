{ pkgs, ... }:
{
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
}
