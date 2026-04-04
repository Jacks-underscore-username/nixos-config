{...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
      italic-text = "always";
      paging = "auto";
      style = "numbers,changes,header";
    };
    themes = {
      "Catppuccin Mocha" = {
        src = builtins.fetchTarball {
          url = "https://github.com/catppuccin/bat/archive/refs/heads/main.tar.gz";
          sha256 = "1y5sfi7jfr97z1g6vm2mzbsw59j1jizwlmbadvmx842m0i5ak5ll";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };
}
