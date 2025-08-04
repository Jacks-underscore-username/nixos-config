{
  lib,
  appimageTools,
  fetchzip,
}: let
  pname = "custom_keet";
  version = "2.5.1";

  src = fetchzip {
    url = "https://keet.io/downloads/${version}/Keet-x64.tar.gz";
    hash = "sha256-mM33Phf9a8+LRSfsaIiJJIQayptdyNW6xa0s7m0mkk8=";
  };

  appimageContents = appimageTools.extract {
    inherit pname version;
    src = "${src}/Keet.AppImage";
  };
in
  appimageTools.wrapType2 {
    inherit pname version;

    src = "${src}/Keet.AppImage";

    extraPkgs = pkgs:
      with pkgs; [
        gtk4
        graphene
      ];

    extraInstallCommands = ''
      install -m 444 -D ${appimageContents}/Keet.desktop -t $out/share/applications
      cp -r ${appimageContents}/*.png $out/share
    '';
  }
