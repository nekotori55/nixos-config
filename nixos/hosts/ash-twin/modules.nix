{ config, ... }:
let
  username = "nekotori55";
in
{
  modules = {
    programs = {
      cli = {
        archive-tools.enable = true;
        nh.enable = true;
      };
      gui = {
        gaming = {
          minecraft.enable = true;
          osu.enable = true;
          steam.enable = true;
        };
      };
    };
    services = {
      agenix.enable = true;
      agenix.install-cli = true;

      solaar.enable = true;
      ssh.enable = true;
      throne.enable = true;
      kde-connect.enable = true;

      printing.enable = true;

      home-manager = {
        enable = true;
        users.${username} = import ./home-modules.nix;
      };
    };

    session = {
      dm.sddm.enable = true;
      desktop.plasma.enable = true;
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