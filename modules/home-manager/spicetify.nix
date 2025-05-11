{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    colorScheme = "Forest";
    alwaysEnableDevTools = true;
    enabledExtensions = with spicePkgs.extensions; [
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
}
