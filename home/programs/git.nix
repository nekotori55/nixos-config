{ ... }:
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
}
