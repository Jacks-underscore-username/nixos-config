{pkgs}:
pkgs.writeShellScriptBin "hyprpaperManager" ''
  sudo bun "/persist/nixos/modules/home-manager/scripts/hyprpaperManager.js" $1 $2
''
