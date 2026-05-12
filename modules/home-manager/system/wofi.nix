{
  pkgs,
  colors,
  ...
}: let
  c = colors;
in {
  home.packages = [pkgs.wofi];

  # Wofi config
  xdg.configFile."wofi/config".text = ''
    width=500
    height=350
    location=center
    show=drun
    prompt=Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=24
    gtk_dark=${if c.themeIsDark then "true" else "false"}
  '';

  # Wofi CSS — fully generated from lib/colors.nix
  xdg.configFile."wofi/style.css".text = ''
    /* ── Inkglow Wofi theme — generated from lib/colors.nix ── */

    * {
      font-family: "FiraCode Nerd Font";
      font-size: 13px;
    }

    window {
      background-color: ${c.bgPanel};
      border: 2px solid ${c.accent};
      border-radius: 12px;
      padding: 0;
    }

    #input {
      background-color: ${c.bgElevated};
      color: ${c.fg};
      caret-color: ${c.accent};
      border: 1px solid ${c.indentGuide};
      border-radius: 8px;
      padding: 8px 12px;
      margin: 10px;
      outline: none;
    }

    #input:focus {
      border-color: ${c.accent};
    }

    #inner-box {
      background-color: transparent;
      padding: 0 8px 8px;
    }

    #outer-box {
      background-color: transparent;
    }

    #scroll {
      background-color: transparent;
    }

    #text {
      color: ${c.fg};
      padding: 2px 4px;
    }

    #entry {
      background-color: transparent;
      border-radius: 6px;
      padding: 4px 8px;
      margin: 1px 0;
    }

    #entry:selected {
      background-color: ${c.accentAlt};
    }

    #entry:selected #text {
      color: ${c.fg};
    }

    #entry image {
      margin-right: 8px;
    }
  '';
}
