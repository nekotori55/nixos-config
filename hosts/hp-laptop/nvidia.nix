{ lib, pkgs, ... }:
with lib.mkDefault;
{
  services.xserver.videoDrivers = [
    "nvidia"
  ];

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;

    nvidiaSettings = true;

    powerManagement = {
      enable = mkDefault false;
      finegrained = false;
    };

    # package =

    prime = {
      # There are three options:

      # OFFLOAD_MODE:
      # Puts your dGPU to sleep and lets the iGPU handle all tasks,
      # except if you call the dGPU specifically by "offloading" an application to it
      #
      # offload = {
      #   enable = true;
      #   enableOffloadCmd;
      # };

      # SYNC_MODE:
      # rendering is completely delegated to the dGPU,
      # while the iGPU only displays the rendered framebuffers copied from the dGPU
      #
      sync.enable = true;

      # REVERSE_SYNC_MODE:
      # The difference between regular sync mode and reverse sync mode is that
      # the dGPU is configured as the primary output device,
      # allowing displaying to external displays wired to it and not the iGPU (more common).
      #
      # reverseSync.enable = true;

      # PRIME sync and reverse sync modes are X11-only and do not work under Wayland.
      # https://wiki.nixos.org/wiki/NVIDIA#Hybrid_graphics_with_PRIME

      # Use 'lshw -c display' to check
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };

  };
}
