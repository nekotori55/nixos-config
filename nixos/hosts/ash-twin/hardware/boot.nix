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

        maxGenerations = 10;

        enrollConfig = true;
        panicOnChecksumMismatch = true;

        secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys = {
            enable = true;
            extraArgs = [
              "--microsoft"
              "--firmware-builtin"
            ];
          };
        };

        extraEntries = ''
          /Windows
          protocol: efi
          comment: Windows Boot Manager (Windows 11)
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi#325eb0ea8811677ef38e48016aad9fd10a0f53b9ff7625291caf6d30ff6129207634450649912cb29b4eaedf303f5c4c8b51f9bb1c84499ace3c36ce720fac2d'';

        # extraEntries = ''
        #     /Windows
        #     protocol: efi_boot_entry
        #     entry: Windows Boot Manager
        # '';

        extraConfig = ''
          quiet: yes
          remember_last_entry: yes
        '';
      };

      timeout = 1;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "fbcon=nodefer"
    ];

    # love nvidia
    initrd.kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];

  };

  system.activationScripts = {
    bootNixosByDefault = {
      text = ''
        TARGET=`${pkgs.systemd}/bin/bootctl list --json=short | ${pkgs.jq}/bin/jq .[0].id`
        ${pkgs.systemd}/bin/bootctl set-oneshot $TARGET
      '';
    };
  };

  environment.systemPackages =
    let
      reboot-to-windows = pkgs.writeShellScriptBin "reboot-to-windows" ''
        bootctl set-oneshot Windows && reboot
      '';

      reboot-to-last = pkgs.writeShellScriptBin "reboot-to-last" ''
        TARGET=`bootctl list --json=short | ${pkgs.jq}/bin/jq .[0].id`
        bootctl set-oneshot $TARGET && reboot
      '';
    in
    [
      pkgs.sbctl
      reboot-to-windows
      reboot-to-last
    ];
}
