{
  inputs,
  pkgs,
  settings,
  lib,
  config,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];
  programs.ags = {
    enable = true;
    configDir = ../../ags;
  };
}
