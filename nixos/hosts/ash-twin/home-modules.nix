{
  modules = {
    programs = {
      gui = {
        librewolf.enable = true;

        ide = {
          enable = true;
          vscode.enable = true;
        };

        social = {
          enable = true;
          discord.enable = true;
          telegram.enable = true;
        };
      };

      cli = {
        direnv.enable = true;
        git.enable = true;
        helix.enable = true;
      };
    };

    settings = {
      aliases.enable = true;
      ssh.enable = true;
    };
  };
}
