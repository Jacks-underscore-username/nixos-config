{pkgs}:
pkgs.writeShellScriptBin "moveWorkspace" ''
  bun "/persist/nixos/modules/home-manager/scripts/moveWorkspace.js" $1
''
