{pkgs}:
pkgs.writeShellScriptBin "hssh" ''
  bun "/persist/nixos/modules/home-manager/scripts/hssh.js" "$@"
''