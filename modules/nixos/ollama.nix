{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = ["phi4-mini-reasoning:3.8b"];
  };
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };
}
