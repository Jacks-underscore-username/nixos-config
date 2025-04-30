{pkgs}:
pkgs.writeShellScriptBin "moveWindow" ''
  bun "/persist/nixos/modules/home-manager/scripts/moveWindow.js" $1
''
