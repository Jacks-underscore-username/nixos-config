{pkgs}:
pkgs.writeShellScriptBin "compareDir" ''
  sudo bun "/persist/nixos/modules/home-manager/scripts/compareDir.js" $1 $2
''
