{pkgs}:
pkgs.writeShellScriptBin "shell" ''
  bun "/persist/nixos/modules/home-manager/scripts/shell.js" $1
''
