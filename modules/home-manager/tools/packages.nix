{
  lib,
  pkgs,
  ...
}: let
  wrapWithMissingLibraries = binaryFile:
    pkgs.writeShellScriptBin (baseNameOf binaryFile) ''
      LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [pkgs.libuuid]}";
      export LD_LIBRARY_PATH
      exec ${binaryFile} "$@";
    '';
in {
  home.packages = with pkgs; [
    git
    gh
    alejandra
    ripgrep
    node2nix
    unstable.biome
    ncdu
    direnv
    picocom
    pkgs.unstable.opencode
    vivid
    fastfetch
    cava

    (
      wrapWithMissingLibraries
      (lib.getExe nodejs_24)
    )
    (
      wrapWithMissingLibraries
      (lib.getExe pkgs.unstable.bun)
    )

    unstable.jetbrains.idea-community
  ];
}
