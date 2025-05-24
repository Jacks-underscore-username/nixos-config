{
  config,
  lib,
  pkgs,
  home,
  ...
}: {
  home.packages = with pkgs; [
    legcord
  ];
}
