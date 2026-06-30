{
  # [Main] HP-Pavilion Gaming 15 laptop running NixOS
  ash-twin = {
    hostname = "ash-twin";
    profile = "workstation";
  };

  # # [Main] HP-Paviliong Gaming 15 laptop WSL
  # ember-twin = nixosSystem {
  #   hostname = "ember-twin";
  #   extra-modules = [ inputs.nixos-wsl.nixosModules.wsl ];
  # };

  # Teclast-F5 laptop
  interloper = {
    hostname = "interloper";
    profile = "workstation";
  };

  # Old repurposed PC
  brittle-hollow = {
    hostname = "brittle-hollow";
    profile = "workstation";
  };

  giants-deep = {
    hostname = "giants-deep";
    profile = "server";
  };
}
