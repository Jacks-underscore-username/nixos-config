{...}: {
  home.persistence."/persist/home/jackc" = {
    allowOther = true;
    directories = [
      ".local/share/PrismLauncher"
      ".config/discord"
      ".ssh"
      ".config/gh"
      ".vscode"
      ".cache/google-chrome"
      ".config/google-chrome"
      ".config/Code"
      ".cache/spotify"
      ".config/spotify"
      ".ssh"
      ".local/share/Steam"
      ".pki"
      ".steam"
    ];
    files = [
    ];
  };
}
