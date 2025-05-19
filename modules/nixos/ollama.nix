{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = ["qwen3:8b" "qwen3:4b" "qwen3:1.7b" "qwen3:0.6b"];
  };
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };
}
