{ ... }:
{
  imports = [
    ./desktop
  ];

  home = {
    # username = "nekotori55";s
    # homeDirectory = "/home/nekotori55";

    file."HOME_MANAGER_ENABLED".text = "or is it?";

    stateVersion = "25.05";
  };
}
