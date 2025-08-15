{
  pkgs,
  home,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    alwaysEnableDevTools = true;
    enabledExtensions = with spicePkgs.extensions; [
      # adblockify
      # hidePodcasts
      shuffle
      # trashbin
      # goToSong
      # playlistIntersection
      # showQueueDuration
      # history
      # betterGenres
      # skipOrPlayLikedSongs
    ];
    theme = spicePkgs.themes.starryNight;
    # colorScheme = "Forest";
  };
  # programs.spicetify = {
  #   enable = true;
  #   colorScheme = "Forest";
  #   alwaysEnableDevTools = true;
  #   enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
  #     adblockify
  #     hidePodcasts
  #     shuffle
  #     trashbin
  #     goToSong
  #     playlistIntersection
  #     showQueueDuration
  #     history
  #     betterGenres
  #   ];
  # };
}
