{pkgs}:
pkgs.writeShellScriptBin "watchWindow" ''
  hyprctl dispatch exec "kitty --class watchWindow bun --eval \"setInterval(()=>console.log(require('child_process').execSync('hyprctl activewindow').toString()), 100)\""
''
