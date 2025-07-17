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
      # "Steam"
      # ".local/share/Steam"
      # ".steam"
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs/jetbrains"
    ];
    files = [
      ".bash_history"
    ];
  };
}
