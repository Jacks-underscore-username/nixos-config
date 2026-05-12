{
  pkgs,
  inputs,
  colors,
  ...
}:
with inputs.spicetify-nix.legacyPackages.${pkgs.system}; {
  programs.spicetify = {
    enable = true;
    alwaysEnableDevTools = true;
    enabledExtensions = with extensions; [
      adblockify
      hidePodcasts
      shuffle
      betterGenres
      skipOrPlayLikedSongs
    ];
    theme = themes.${colors.spicetifyTheme};
    colorScheme = colors.spicetifyColorScheme;
  };
}
