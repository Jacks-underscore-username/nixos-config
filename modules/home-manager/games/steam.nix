{
  config,
  pkgs,
  ...
}: let
  persist = home.persistence."/persist/home/jackc";
in {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      nss_latest
      zlib
      alsa-lib
      libpulseaudio
      vulkan-loader
    ];
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  persist = persist ++ [];
}
