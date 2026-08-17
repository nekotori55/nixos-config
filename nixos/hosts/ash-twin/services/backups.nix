{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    restic-rest-server
    restic
  ];  
}