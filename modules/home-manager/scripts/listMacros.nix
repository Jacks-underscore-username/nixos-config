{pkgs}:
pkgs.writeShellScriptBin "listMacros" ''
  bun "/persist/nixos/modules/home-manager/scripts/listMacros.js" "$@"
''
