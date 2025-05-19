{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = ["phi4-reasoning:14b"];
  };
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };
}
