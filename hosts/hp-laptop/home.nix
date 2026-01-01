{ lib, pkgs, ... }:
{
  # System
  home.stateVersion = "26.05";

  # Essentials
  programs.git = {
    enable = true;
    userEmail = "nekotori55@gmail.com";
    userName = "nekotori55";
    lfs.enable = true;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      # TODO
      # keys.normal = {
      #   C-f = [
      #     ":new"
      #     ":insert-output lf -selection-path=/dev/stdout"
      #     "split_selection_on_newline"
      #     "goto_file"
      #     "goto_last_modification"
      #     "goto_last_modified_file"
      #     ":buffer-close!"
      #     ":redraw"
      #   ];
      # };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];
  };

}
