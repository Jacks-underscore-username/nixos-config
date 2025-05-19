{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = ["qwen3:8b"];
  };
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };
}
