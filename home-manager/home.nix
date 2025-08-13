{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../modules/home-manager/default.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  home = {
    username = "jackc";
    homeDirectory = "/home/jackc";
  };

  # TODO: Break these into modules:
  home.packages = let
    wrapWithMissingLibraries = binaryFile:
      pkgs.writeShellScriptBin (baseNameOf binaryFile) ''
        LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [pkgs.libuuid]}";
        export LD_LIBRARY_PATH
        exec ${binaryFile} "$@";
      '';
  in
    with pkgs; [
      git
      gh
      vscode
      waybar
      dunst
      libnotify
      swww
      kitty
      wofi
      google-chrome
      pkgs.unstable.nerd-fonts.fira-code
      alejandra
      ripgrep
      (import ../modules/home-manager/scripts/reload.nix {inherit pkgs;})
      qt5.full
      hyprpolkitagent
      man-pages
      man-pages-posix
      linux-manual
      lutris
      networkmanagerapplet
      waybar
      playerctl
      xfce.thunar
      killall
      hyprpaper
      hyprpicker
      obs-studio
      jetbrains.idea-community
      (import ../modules/home-manager/scripts/cycleWorkspace.nix {inherit pkgs;})
      (
        wrapWithMissingLibraries
        (lib.getExe nodejs_24)
      )
      node2nix
      (
        wrapWithMissingLibraries
        (lib.getExe pkgs.unstable.bun)
      )
      (import ../modules/home-manager/scripts/completeOrphan.nix {inherit pkgs;})
      udisks
      rrsync
      p7zip
      biome
      (import ../modules/home-manager/scripts/createWorkspace.nix {inherit pkgs;})
      grim
      swappy
      slurp
      wl-clipboard
      zig
      hyprpaper
      hyprcursor
      hyprdim
      brightnessctl
      zip
      dunst
      prismlauncher
      libglvnd
      yad
      glfw
      glfw-wayland
      (import ../modules/home-manager/scripts/moveWorkspace.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/moveWindow.nix {inherit pkgs;})
      libxkbcommon
      glib
      wineWowPackages.stable
      gradle
      networkmanagerapplet
      gnome-system-monitor
      (import ../modules/home-manager/scripts/deflate.nix {inherit pkgs;})
      ncdu
      usbutils
      udiskie
      udisks

      # glfw3-minecraft
      openal

      ## openal
      alsa-lib
      libjack2
      libpulseaudio
      pipewire

      ## glfw
      libGL
      xorg.libX11
      xorg.libXcursor
      xorg.libXext
      xorg.libXrandr
      xorg.libXxf86vm

      udev # oshi

      vulkan-loader # VulkanMod's lwjgl

      flite

      openscad

      (import ../modules/home-manager/scripts/compareDir.nix {inherit pkgs;})

      htop

      hyprpaper
      (import ../modules/home-manager/scripts/hyprpaperManager.nix {inherit pkgs;})

      jellyfin-ffmpeg

      (import ../modules/home-manager/scripts/toggleLightMode.nix {inherit pkgs;})

      pkgs.unstable.ollama
      ags

      keet
      custom_keet

      balatro
      # balatro-mobile-maker

      (import ../modules/home-manager/scripts/createMacro.nix {inherit pkgs;})
      # <MACRO INSERT>
      (import ../modules/home-manager/scripts/git_plog.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/git_plog.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/hardReboot.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/lineCounter.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/watchBuffer.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/shell.nix {inherit pkgs;})
      (import ../modules/home-manager/scripts/copyJsConfig.nix {inherit pkgs;})
    ];

  # programs.nix-index.enable = true;

  # programs.nushell = {
  #   enable = true;
  #   extraConfig = ''
  #     $env.config.hooks.command_not_found = source ${pkgs.nix-index}/etc/profile.d/command-not-found.nu
  #   '';
  # };

  # Let home manager manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
