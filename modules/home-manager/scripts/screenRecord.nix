{pkgs}:
pkgs.writeShellScriptBin "screenRecord" ''
  if pgrep -f gpu-screen-recorder >/dev/null 2>&1
    then
      echo "running"
    else
      echo "not running"
  fi
''
