{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  services.xserver.enable = true;

  programs.hyprland.enable = true;

  services.libinput.enable = true;

  fonts.packages = [pkgs.unstable.nerd-fonts.fira-code];
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.fontconfig.defaultFonts = {
    serif = ["FiraCode Nerd Font"];
    sansSerif = ["FiraCode Nerd Font"];
    monospace = ["FiraCode Nerd Font"];
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    PATH = "$HOME/.config/pear/bin";
  };
}
