{...}: {
  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      ".local/share/PrismLauncher"
      # ".config/discord"
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
      # ".local/share/Steam"
      # ".pki"
      # ".steam"
    ];
    files = [
    ];
  };
}
