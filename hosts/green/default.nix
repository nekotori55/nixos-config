{
  pkgs,
  config,
  lib,
  ...
}:
let
  commonHyprlandGreenConfig = ''
    # Laptop multimedia keys for volume and LCD brightness
    bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
    bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

    # Requires playerctl
    bindl = , XF86AudioNext, exec, playerctl next
    bindl = , XF86AudioPause, exec, playerctl play-pause
    bindl = , XF86AudioPlay, exec, playerctl play-pause
    bindl = , XF86AudioPrev, exec, playerctl previous
  '';
in
{
  imports = [
    ./hardware.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  modules = {
    home.useHomeManager = true;
    desktop = {
      wm = "hyprland";
      hyprland = {
        mutableConfigFile.enable = true;
      };
    };

    home.apps = {
      browsers.librewolf.enable = false;
    };
  };

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    zed-editor
    hyprpolkitagent
    v2rayn
    v2ray-domain-list-community
    v2ray-geoip
    v2ray
    xray
    # nfqws
  ];

  # services.zapret = {
  #   enable = true;
  #   params = [
  #     "--dpi-desync=split2 --dpi-desync-ttl=5 --wssize 1:6 --dpi-desync-fooling=md5sig"
  #     "--dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-repeats=6"
  #   ];
  # };
  #
  services.zapret = {
    enable = true;
    params = [
      # Discord voice channels & screen sharing
      "--filter-udp=50000-65535"
      "--filter-l7=discord,stun"
      "--dpi-desync=fake,tamper"
      "--dpi-desync-any-protocol"
      "--new"

      # TCP port 80 filter (HTTP) - Youtube & Discord
      "--filter-tcp=80"
      "--dpi-desync=fake,split2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=md5sig"
      "--new"

      # TCP port 443 filter (HTTPS) - Youtube & Discord
      "--filter-tcp=443"
      # "--dpi-desync=fake"
      "--dpi-desync=split2"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-fake-tls-mod=rnd,rndsni,padencap"

      # UDP port 443 filter (QUIC) - Youtube
      "--filter-udp=443"
      "--dpi-desync=fake"
      "--dpi-desync-udplen-increment=10"
      "--dpi-desync-repeats=6"
      "--dpi-desync-udplen-pattern=0xDEADBEEF"
    ];
    udpSupport = true;
    udpPorts = [
      "50000:65535"
      "443"
    ];
    configureFirewall = false;
  };

  # systemd.services.hyprpolkitagent.wantedBy = [ "multi-user.target" ];
  #
  services.resolved = {
    enable = true;
    # dnssec = "true";
    # domains = [ "~." ];
    # fallbackDns = [ "8.8.8.8" ];
    # dnsovertls = "true";
  };

  # services.zapret.enable = true;
  # services.zapret = {
  #   # blacklist = [ "discord.com " ];
  #   #
  #   udpSupport = true;

  #   udpPorts = [
  #     "45000:65535"
  #   ];

  #   params = [
  #     "--dpi-desync=fake,disorder2"
  #     "--dpi-desync-ttl=9"
  #     "--dpi-desync-autottl=2"
  #     "--dpi-desync-any-protocol"
  #     "--dpi-desync=fakedsplit"
  #     "--dpi-desync-fooling=badseq"
  #     "--dpi-desync-split-pos=midsl"
  #     "--split-pos=method+2"
  #     "--dpi-desync-fake-tls=0x00000000"
  #     "--dpi-desync-fake-tls-mod=rnd"
  #     "--dpi-desync-fake-tls=! ,rndsni,dupsid"
  #   ];
  # };
  #
  #
  #

  # services.zapret = {
  #   enable = false;
  #   params = [
  #     "--filter-udp=50000-50099 --filter-l7=discord,stun --dpi-desync=fake --new" # For Discord voice chats
  #     "--dpi-desync=fake split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig"
  #   ];
  # };

  programs.nekoray = {
    enable = true;
    tunMode = {
      enable = true;
      setuid = true;
    };
  };

  security.polkit.enable = true;
  # security.polkit.extraConfig = ''
  #       polkit.addRule(function(action, subject) {
  #       if (
  #         action.id == "org.freedesktop.policykit.exec" &&
  #         (action.lookup("command_line").indexOf(' /home/' + subject.user + '/.config/nekoray/config/vpn-run-root.sh') !== -1)
  #         )
  #         {
  #         return polkit.Result.YES;
  #         }
  #       });
  #     '';

  nixpkgs.config.allowUnfree = true;

  # DEFAULT SPECIALIZATION (docked)
  modules.desktop.hyprland.hostConfig = lib.mkIf (config.specialisation != { }) (
    ''
      # DEVICE-SPECIFIC
      env = AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2

      # DEVICE-SPECIFIC
      monitor = eDP-1, 1920x1080@60, 0x0, 1
      monitor = HDMI-A-1, 1920x1080@144, 1920x0, 1

      # NVIDIA-SPECIFIC
      env = LIBVA_DRIVER_NAME,nvidia
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia

      cursor {
        no_hardware_cursors = true
      }

      workspace = 11, monitor:HDMI-A-1
      workspace = 12, monitor:HDMI-A-1
      workspace = 13, monitor:HDMI-A-1
      workspace = 14, monitor:HDMI-A-1
      workspace = 15, monitor:HDMI-A-1
      workspace = 16, monitor:HDMI-A-1
      workspace = 17, monitor:HDMI-A-1
      workspace = 18, monitor:HDMI-A-1
      workspace = 19, monitor:HDMI-A-1
      workspace = 20, monitor:HDMI-A-1

      workspace = 1, monitor:eDP-1
      workspace = 2, monitor:eDP-1
      workspace = 3, monitor:eDP-1
      workspace = 4, monitor:eDP-1
      workspace = 5, monitor:eDP-1
      workspace = 6, monitor:eDP-1
      workspace = 7, monitor:eDP-1
      workspace = 8, monitor:eDP-1
      workspace = 9, monitor:eDP-1
      workspace = 10, monitor:eDP-1

      exec-once = systemctl --user start hyprpolkitagent
    ''
    + commonHyprlandGreenConfig
  );

  # ON THE GO SPECIALIZATION
  specialisation = {
    on-the-go.configuration = {
      environment.etc."specialisation".text = "on-the-go";

      modules.desktop.hyprland.hostConfig = (
        ''
          monitor = eDP-1, 1920x1080@60, 0x0, 1

          env = AQ_DRM_DEVICES,/dev/dri/card2
        ''
        + commonHyprlandGreenConfig
      );
    };
  };

  time.timeZone = "Europe/Istanbul";

  # add on first install
  system.stateVersion = "25.05";
}
