{pkgs, ...}: {
  home.packages = with pkgs; [
    # Wayland / Hyprland
    waybar
    dunst
    libnotify
    swww
    kitty
    fish
    wofi
    hyprpolkitagent
    hyprpaper
    hyprpicker
    hyprcursor
    hyprdim
    brightnessctl
    playerctl
    networkmanagerapplet

    # Browser
    google-chrome

    # Fonts
    pkgs.unstable.nerd-fonts.fira-code

    # Desktop apps
    qt5.full
    xfce.thunar
    obs-studio
    gnome-system-monitor
    openscad
    blender
    keet
    unstable.olympus

    # Screenshots / screen recording
    grim
    swappy
    slurp
    wl-clipboard

    # Wine
    winetricks
    freetype
    fontconfig

    # System utilities
    killall
    man-pages
    man-pages-posix
    linux-manual
    udisks
    usbutils
    udiskie
    rrsync
    p7zip
    zip
    jellyfin-ffmpeg

    # Gaming libs
    prismlauncher
    libglvnd
    yad
    glfw

    # Minecraft deps (openal)
    alsa-lib
    libjack2
    libpulseaudio
    pipewire

    # Minecraft deps (glfw)
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXext
    xorg.libXrandr
    xorg.libXxf86vm

    udev # oshi
    vulkan-loader # VulkanMod's lwjgl
  ];
}
