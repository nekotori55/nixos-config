{
  config,
  pkgs,
  lib,
  ...
}:
{
  # NVIDIA
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages =
    (with pkgs; [
      lshw # sudo lshw -c display    # to check bus id's

      libva-utils
      vdpauinfo
      vulkan-tools
      vulkan-validation-layers
      libvdpau-va-gl
      egl-wayland
      wgpu-utils
      mesa
      libglvnd
      nvtopPackages.full
      nvitop
      libGL

    ])
    ++ (with pkgs; [ vkdevicechooser ]);

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
  ];

  environment.sessionVariables = {
    GSK_RENDERER = "cairo";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    #forceFullCompositionPipeline = true;

    powerManagement = {
      enable = false; # no way it works in sync mode
      finegrained = false; # works on turing or newer (should check)
    };

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      # option A: Offload Mode         // nvidia sleepy - amd worky; amd can ask nvidia for help (nvidia-offload)
      # https://nixos.wiki/wiki/Nvidia
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };

      # option B: Sync Mode           // nvidia worky for the most,  but nvidia eats a lot (of energy)
      sync.enable = true;

      # option C: Reverse Sync Mode (experimental)     // amd worky but good external monitors compat i guesss
      #reverseSync.enable = true;
      #allowExternalGpu = false; #// I guess my gpu is very internal

      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  specialisation = {
    on-the-go.configuration = {
      hardware.bluetooth.powerOnBoot = false;

      hardware.nvidia.prime = {
        # please behave
      };

      # disable nvidia

      boot.extraModprobeConfig = lib.mkDefault ''
        blacklist nouveau
        options nouveau modeset=0
      '';

      services.udev.extraRules = lib.mkDefault ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
      boot.blacklistedKernelModules = lib.mkDefault [
        "nouveau"
        "nvidia"
      ];
    };
  };
}
