{pkgs}:
pkgs.writeShellScriptBin "hyprpaperManager" ''
  bun "/persist/nixos/modules/home-manager/scripts/hyprpaperManager.js" $1
''
