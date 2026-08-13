let
  username = "nekotori55";  
in
{
  modules = {
    programs.cli.archive-tools.enable = true;

    services = {
      agenix.enable = true;

      fail2ban.enable = true;
      ssh = {
        enable = true;
        hardening = true;
      };


      home-manager = {
        enable = true;
        users.${username} = {
          modules = {
            programs.cli.helix.enable = true;
          };
        };
      };
    };

    settings = {
      default-user = {
        enable = true;
        username = username;
      };

      nix.enable = true;
    };
  };
}