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

      ".local/share/Steam"
      # ".steam"
      # ".cache/fontconfig"
      # ".cache/mesa_shader_cache_db"
      # ".compose-cache"
    ];
    files = [
      # ".pulse-cookie"
      ".bash_history"
    ];
  };
}
