{...}: {
  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      ".local/share/PrismLauncher"
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
      ".local/share/Steam"
      ".cache/fontconfig"
      ".cache/mesa_shader_cache_db"
      ".compose-cache"

      ".factorio"
      ".local/share/Celeste"
      "Desktop"
      ".local/share/applications"

      ".config/pear-runtime"
      ".config/pear"
      "..cache/gtk-4.0"
    ];
    files = [
      ".steam/steam.token"
      ".pulse-cookie"
      ".bash_history"
    ];
  };
}
