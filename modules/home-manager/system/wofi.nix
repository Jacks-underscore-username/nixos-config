{...}: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 28;
      columns = 1;
    };
    style = ''
      /* Catppuccin Mocha */
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color crust #11111b;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;
      @define-color overlay0 #6c7086;
      @define-color text #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color lavender #b4befe;
      @define-color blue #89b4fa;
      @define-color red #f38ba8;

      window {
        margin: 0;
        border: 2px solid @surface0;
        border-radius: 16px;
        background-color: alpha(@base, 0.9);
        font-family: "FiraCode Nerd Font";
        font-size: 14px;
      }

      #input {
        padding: 10px 16px;
        margin: 8px;
        border: none;
        border-radius: 12px;
        color: @text;
        background-color: @surface0;
        font-size: 14px;
      }

      #input:focus {
        border: 2px solid @lavender;
        background-color: alpha(@surface1, 0.8);
      }

      #inner-box {
        margin: 4px 8px;
      }

      #outer-box {
        margin: 0;
        padding: 0;
      }

      #scroll {
        margin: 0;
      }

      #text {
        color: @text;
        margin: 0;
      }

      #entry {
        padding: 8px 12px;
        margin: 2px 0;
        border-radius: 10px;
        transition: all 0.1s ease;
      }

      #entry:selected {
        background-color: alpha(@lavender, 0.15);
        border: none;
      }

      #entry:selected #text {
        color: @lavender;
      }
    '';
  };
}
