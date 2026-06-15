{...}: {
  networking.hostName = "Nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    3000
    3001
    5500
  ];
}
