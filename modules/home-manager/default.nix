{
  imports = [
    ./hyprland.nix
    ./java.nix
    ./git.nix
    ./spicetify.nix
    ./permanence.nix
  ];

  hyprland.monitors = [
    ",preferred,auto,1"
    "eDP-1,2880x1800@90Hz,0x1000,1.8"
    # "DP-2,2560x1600,0x0,1.6"
    # "DP-4,1920x1080@60Hz,1600x300,1"
    # "DP-5,1920x1080@60Hz,1600x300,1"
    # "DP-1,2560x1600@60Hz,-1000x375,1.6,transform,3"

    "DP-3,3840x1600,-1920x-600,1"
  ];
}
