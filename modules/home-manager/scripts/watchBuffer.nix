{pkgs}:
pkgs.writeShellScriptBin "watchBuffer" ''
  watch -n1 'grep -E "(Dirty|Write)" /proc/meminfo; echo; ls /sys/block/ | while read device; do awk "{ print \"$device: \"  \$9 }" "/sys/block/$device/stat"; done'
''
