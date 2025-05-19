{pkgs, ...}: {
  services.ollama = {
    enable = true;
    package = pkgs.unstable.ollama;
    loadModels = ["deepseek-r1:7b" "qwen3:0.6b"];
  };
  services.open-webui = {
    enable = true;
    package = pkgs.unstable.open-webui;
  };
}
