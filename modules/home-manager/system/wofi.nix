{colors, ...}: let
  c = colors;
in {
  xdg.configFile."wofi/style.css".text = ''
    window {
      font-family: "FiraCode Nerd Font";
      font-size: 14px;
      background-color: ${c.bg_dark};
      color: ${c.fg};
      border: 2px solid ${c.bg_highlight};
      border-radius: 12px;
    }

    #input {
      background-color: ${c.bg};
      color: ${c.fg};
      border: 1px solid ${c.bg_highlight};
      border-radius: 8px;
      margin: 8px;
      padding: 8px 12px;
    }

    #input:focus {
      border-color: ${c.blue};
    }

    #outer-box {
      margin: 0;
      padding: 0;
    }

    #scroll {
      margin: 0 8px 8px 8px;
    }

    #entry {
      padding: 6px 12px;
      border-radius: 8px;
    }

    #entry:selected {
      background-color: ${c.bg_visual};
      color: ${c.fg};
    }

    #text {
      color: ${c.fg};
    }

    #text:selected {
      color: ${c.fg};
    }
  '';

  xdg.configFile."wofi/config".text = ''
    width=500
    height=400
    show=drun
    prompt=Search...
    allow_images=true
    image_size=24
    insensitive=true
  '';
}
