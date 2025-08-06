{
  config,
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    # Crucial for many games, especially those needing specific runtime components
    # Add common 32-bit libraries that Proton/Wine often rely on.
    # These correspond to the Windows DLLs.
    extraCompatPackages = with pkgs; [
      # Networking
      nss_latest
      zlib # Often needed by networking components

      # General system libs often implicitly linked or needed
      alsa-lib # Audio
      libpulseaudio # Audio (if you use PulseAudio)
      # libx11 # Xorg core
      # libxext # X extension library
      # libxfixes # X fixes
      # libxrandr # X RandR extension
      # libxrender # X Render extension
      # libxi # XInput
      # libxcb # X protocol C-language Binding
      # libxxf86vm # XFree86-VidMode Extension

      # Graphics/Vulkan (even if you have hardware.opengl enabled)
      vulkan-loader # Ensure Vulkan loader is present
      # For NVIDIA users with Vulkan issues:
      # libnvidia-container # Often useful for NVIDIA and containers/Proton
    ];
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # VERY IMPORTANT!
    # If NVIDIA:
    # enableNvidia = true;
    # package = config.hardware.nvidia.drivers.package;
  };
}
