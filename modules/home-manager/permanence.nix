{...}: {
  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      # ".local/share/PrismLauncher"
      ".ssh"
      ".config/gh"
      ".vscode"
      # ".cache/google-chrome"
      ".config/google-chrome"
      ".config/Code"
      # ".cache/spotify"
      ".config/spotify"
      ".config/legcord"
      "Steam"
      ".pki"
      # ".local/share/Steam"
      ".steam"

      ".local"
      ".cache"
    ];
    files = [
      ".bash_history"
    ];
  };
}
