{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  runtimeLibs = with pkgs; [
    ## native versions
    glfw3-minecraft
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

    home-manager

    fuse
  ];
in {
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager

    ./disko.nix

    ../modules/nixos/default.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib"
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  programs.fuse.userAllowOther = true;

  # So if the hyprland config doesn't load so I can still use the default terminal
  environment.systemPackages = [pkgs.kitty];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", MODE="0666", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="000c", MODE="0666", GROUP="plugdev", TAG+="uaccess"
  '';

  systemd.tmpfiles.rules = [
    "d /persist/home/ 1777 root root -" # /persist/home created, owned by root
    "d /persist/home/jackc 0770 jackc users -" # /persist/home/jackc created, owned by that user
  ];

  users.users.jackc = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "plugdev" "dialout" "tty"];
    # TODO: Figure out actual passwords.
    initialPassword = "0";
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users.jackc = import ../home-manager/home.nix;
  };

  # Enable networking
  networking.hostName = "Nixos";
  networking.networkmanager.enable = true;

  # Set up bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.re
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # TODO: WIT
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable hyprland.
  programs.hyprland.enable = true;

  # Fix problems with pixelated apps due to hyprland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Make home manager not complain as much.
  home-manager.backupFileExtension = "backup";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # TODO: ?
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Make everything firacode
  fonts.packages = [pkgs.unstable.nerd-fonts.fira-code];
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = ["FiraCode Nerd Font"];
    sansSerif = ["FiraCode Nerd Font"];
    monospace = ["FiraCode Nerd Font"];
  };

  networking.firewall.allowedTCPPorts = [
    22 # SSH, usually allowed
    80 # HTTP
    443 # HTTPS
    3000 # <-- ADD THIS LINE FOR YOUR SERVER
  ];

  # TODO: WIT
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = runtimeLibs;

  environment.variables.LD_LIBRARY_PATH = lib.makeLibraryPath runtimeLibs;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
