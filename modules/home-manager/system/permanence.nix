{home, ...}: {
  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      ".ssh"
      ".config/gh"
      ".vscode"
      ".cache/google-chrome"
      ".config/google-chrome"
      ".config/Code"
      ".cache/spotify"
      ".config/spotify"
      ".config/legcord"
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs/jetbrains"

      # DO NOT DO ".steam"!!!
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
      ".cache/fontconfig"
      ".cache/mesa_shader_cache_db"
      ".compose-cache"

      ".factorio"
      ".local/share/Celeste"
      # Something for celeste I think
      # ".compose-cache/l4_030_04b84530_0e7768ba"
      "Desktop"
      ".local/share/applications"

      ".config/obs-studio"

      ".config/pear-runtime"
      ".config/pear"
      ".cache/gtk-4.0"

      ".pki"
      ".local/share/PrismLauncher"

      # ".gradle"

      {
        directory = ".gradle";
        method = "symlink";
      }

      ".cache/zig"
      ".cache/zls"

      ".local/share/fish"
    ];
    files = [
      ".steam/steam.token"
      ".pulse-cookie"
      ".bash_history"
    ];
  };
}
