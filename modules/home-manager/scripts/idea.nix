{pkgs}:
pkgs.writeShellScriptBin "idea" ''
  hyprctl dispatch exec 'idea-community "$(pwd)"'
''
