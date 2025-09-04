{pkgs}:
pkgs.writeShellScriptBin "lineCounter" ''
  bun "/persist/nixos/modules/home-manager/scripts/lineCounter.js \"$@\""
''
