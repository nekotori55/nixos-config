{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Archiving tools
    zip
    unzip
    rar

    # Productivity
    tasktimer
  ];
}
