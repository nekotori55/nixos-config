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
 path: uuid(89b99b0a-0d77-4dda-9caf-1577524d5a34):/EFI/Microsoft/Boot/bootmgfw.efi#bf54ae4c759a239c2dc64dd6c48e1cc742e9666c2544714e70dc789a2b0e019731012cb68d64c22a7e4cbe505c556ba9d6c92072dcac53043f224e2fe5e69ab2'';

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
    initrd.kernelModules = [
      "nvidia"
      "nvidia_drm"
    ];

  };

  system.activationScripts = {
    bootNixosByDefault = {
      # deps = [ "bootloader" ];
      text = ''
        ${pkgs.systemd}/bin/bootctl set-oneshot 3
      '';
    };
  };

  environment.systemPackages =
    let
      reboot-to-windows = pkgs.writeShellScriptBin "reboot-to-windows" ''
        bootctl set-oneshot Windows && reboot
      '';
    in
    [
      pkgs.sbctl
      reboot-to-windows
    ];
}
