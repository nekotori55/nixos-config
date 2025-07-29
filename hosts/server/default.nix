{ pkgs, config, lib, ... }:
{
  imports = [
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    
  ];

  nixpkgs.config.allowUnfree = false;

  time.timeZone = "Europe/Istanbul";

  modules.home.user = {
    name = "nekotori55";
    initialPassword = "changeme123";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
    home = "/home/nekotori55";
  };

  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
    PasswordAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
  };
};

  # add on first install
  #   system.stateVersion = "23.05";
}
