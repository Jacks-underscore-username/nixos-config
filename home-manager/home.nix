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
      outputs.overlays.unstable-small-packages
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
    with pkgs;
      [
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
        networkmanagerapplet
        waybar
        playerctl
        xfce.thunar
        killall
        hyprpaper
        hyprpicker
        obs-studio
        unstable.jetbrains.idea-community
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
        unstable.biome
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
        pkgs.unstable-small.gradle_9
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

        openscad

        (import ../modules/home-manager/scripts/compareDir.nix {inherit pkgs;})

        htop

        hyprpaper
        (import ../modules/home-manager/scripts/hyprpaperManager.nix {inherit pkgs;})

        jellyfin-ffmpeg

        (import ../modules/home-manager/scripts/toggleLightMode.nix {inherit pkgs;})

        # pkgs.unstable.ollama
        # ags

        keet

        winetricks
        freetype
        fontconfig

        unstable.olympus

        direnv
      ]
      ++ [
        (import ../modules/home-manager/scripts/createMacro.nix {inherit pkgs;})
        # <MACRO INSERT>
        (import ../modules/home-manager/scripts/7zip.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/denode.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/rs.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/rn-regex.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/mv-regex.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/cp-regex.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/git-clone-regex.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/rm-regex.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/nix-find.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/watchWindow.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/listMacros.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/hssh.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/nix-repl.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/newAlias.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/newMacro.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/createAlias.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/git_plog.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/git_plog.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/hardReboot.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/lineCounter.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/watchBuffer.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/shell.nix {inherit pkgs;})
        (import ../modules/home-manager/scripts/copyJsConfig.nix {inherit pkgs;})
      ];

  # Let home manager manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs.
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
