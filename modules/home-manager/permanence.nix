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
      ".ssh"
      ".config/legcord"
      "Steam"
      ".pki"
      # ".local/share/Steam"
      # ".pki"
      # ".steam"
    ];
    files = [
      ".bash_history"
    ];
  };
}
