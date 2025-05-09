# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  imports = [
    ./hyprland.nix
    ./java.nix
    ./git.nix
  ];

  hyprland.monitors = [
    ",preferred,auto,1"
    "eDP-1,2880x1800@90Hz,0x1000,1.8"
    "DP-2,2560x1600,0x0,1.6"
    "DP-4,1920x1080@60Hz,1600x300,1"
    "DP-5,1920x1080@60Hz,1600x300,1"
    "DP-1,2560x1600@60Hz,-1000x375,1.6,transform,3"
  ];
}
