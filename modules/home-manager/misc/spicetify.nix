{
  pkgs,
  home,
  inputs,
  ...
}: {
  programs.spicetify = {
    enable = true;
    colorScheme = "Forest";
    alwaysEnableDevTools = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblockify
      hidePodcasts
      shuffle
      trashbin
      goToSong
      playlistIntersection
      showQueueDuration
      history
      betterGenres
    ];
  };

  # home.packages = home.packages ++ [pkgs.spotify-tui];
}
