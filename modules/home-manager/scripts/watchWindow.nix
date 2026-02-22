{pkgs}:
pkgs.writeShellScriptBin "watchWindow" ''
  hyprctl dispatch exec "fish --class watchWindow bun \"/persist/nixos/modules/home-manager/scripts/watchWindow.js\" \"$@\""
''
