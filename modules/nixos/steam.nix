{
  config,
  pkgs,
  inputs,
  home,
  ...
}: let
  runtimeLibs = import ../../lib/runtimeLibs.nix {inherit pkgs;};
in {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages =
      runtimeLibs
      ++ (with pkgs; [
        proton-ge-bin
      ]);
  };
  programs.steam.package = pkgs.steam.override {
    extraPkgs = pkgs':
      with pkgs';
        [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ]
        ++ runtimeLibs;
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH = [
      "${pkgs.krb5}/lib"
      "${pkgs.libkrb5}/lib"
      "${pkgs.libtirpc}/lib"
    ];
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
