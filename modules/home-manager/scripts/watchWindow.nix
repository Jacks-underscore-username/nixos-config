{pkgs}:
pkgs.writeShellScriptBin "watchWindow" ''
  hyprctl dispatch exec "kitty --class watchWindow bun \"/persist/nixos/modules/home-manager/scripts/watchWindow.js\" \"$@\""
''
