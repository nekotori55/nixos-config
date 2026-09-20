{ pkgs, ... }:
{
  boot = {
    loader = {
      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   efiSupport = true;
      #   useOSProber = true;
      #   default = "saved";
      #   gfxmodeEfi = "1920x1080";
      # };
      efi.canTouchEfiVariables = true;

      limine = {
        enable = true;

        secureBoot = {
          enable = true;
          autoEnrollKeys.enable = false;
        };

        extraEntries = ''
          /Windows
                  protocol: efi
                  path: uuid(89b99b0a-0d77-4dda-9caf-1577524d5a34):/EFI/Microsoft/Boot/bootmgfw.efi
        '';

        extraConfig = ''
          quiet: yes
        '';
      };

      timeout = 0;
    };

    plymouth = {
      enable = true;
      theme = "lone";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "lone" ];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "fbcon=nodefer"
    ];

    # love nvidia
    initrd.kernelModules = [ "nvidia" "nvidia_drm" ];

  };

  environment.systemPackages =
    let
      reboot-to-windows = pkgs.writeShellScriptBin "reboot-to-windows" ''
        bootctl set-default Windows && reboot
      '';
    in
    [
      pkgs.sbctl
      reboot-to-windows
    ];
}
