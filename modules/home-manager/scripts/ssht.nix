{pkgs}:
pkgs.writeShellScriptBin "ssht" ''
  /usr/bin/ssh -t "$@" tmux new -A "Jack"
''
