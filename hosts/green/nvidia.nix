{ config, ... }:
{
  # NVIDIA
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    #forceFullCompositionPipeline = true;

    powerManagement = {
      enable = false; # disable if artefacts
      finegrained = false; # works on turing or newer (should check)
    };

    package = config.boot.kernelPackages.nvidiaPackages.beta;

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
}
