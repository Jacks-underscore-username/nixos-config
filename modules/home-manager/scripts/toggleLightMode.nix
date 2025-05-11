{pkgs}:
pkgs.writeShellScriptBin "toggleLightMode" ''
  bun "/persist/nixos/modules/home-manager/scripts/toggleLightMode.js"
''
