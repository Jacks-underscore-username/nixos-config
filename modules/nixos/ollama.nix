{pkgs, ...}: {
  services.ollama = {
    package = pkgs.unstable.ollama;
    enable = true;
    loadModels = ["phi4-reasoning:14b"];
  };
  services.open-webui.enable = true;
}
