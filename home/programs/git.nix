{ pkgs, ... }:
{
  programs.git = {
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

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  services.git-sync = {
    enable = true;

    repositories =
      let
        reposPath = "/home/nekotori55/";
      in
      {
        wallpapers = {
          path = "${reposPath}/wallpapers";
          uri = "git@github.com:nekotori55/wallpapers.git";
          interval = 60;
          extraPackages = with pkgs; [ git-lfs ];
        };

        notes = {
          path = "${reposPath}/notes";
          uri = "git@github.com:nekotori55/notes.git";
          interval = 60;
          extraPackages = with pkgs; [ git-lfs ];
        };
      };
  };
}
