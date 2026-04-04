{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
      "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.smoothScrolling" = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = "active";
      "editor.renderWhitespace" = "boundary";
      "editor.minimap.enabled" = false;
      "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
      "terminal.integrated.fontSize" = 13;
      "window.titleBarStyle" = "custom";
      "workbench.list.smoothScrolling" = true;
      "workbench.sideBar.location" = "right";
    };
  };
}
