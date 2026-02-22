{pkgs}:
pkgs.writeShellScriptBin "ssht" ''
  /run/current-system/sw/bin/ssh -t "$@" tmux new -A "Jack"
''
