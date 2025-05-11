# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
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
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  home = {
    username = "jackc";
    homeDirectory = "/home/jackc";
  };

  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      ".local/share/PrismLauncher"
      ".config/discord"
      ".ssh"
      ".config/gh"
      ".vscode"
      ".cache/google-chrome"
      ".config/google-chrome"
      ".config/Code"
      ".cache/spotify"
      ".config/spotify"
    ];
    files = [
    ];
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    git
    gh
    vscode
    discord
    waybar
    dunst
    libnotify
    swww
    kitty
    wofi
    steam
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
    nodejs_23
    bun
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
  ];

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
