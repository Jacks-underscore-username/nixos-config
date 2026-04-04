{lib, ...}: {
  imports = [
    ./dunst.nix
    ./fish.nix
    ./hyprland.nix
    ./kitty.nix
    ./permanence.nix
    ./java.nix
    ./packages.nix
    ./waybar.nix
    ./wofi.nix
  ];

  hyprland.monitors = let
    cleanFloatString = floatValue: let
      floatStr = lib.strings.floatToString floatValue;
      removeTrailingZeroChars = s: let
        len = lib.strings.stringLength s;
        lastChar = lib.strings.substring (len - 1) 1 s;
        beforeLast = lib.strings.substring 0 (len - 1) s;
      in
        if len > 0 && lastChar == "0" && lib.strings.hasInfix "." s
        then removeTrailingZeroChars beforeLast
        else s;
      removeTrailingDotChar = s: let
        len = lib.strings.stringLength s;
        lastChar = lib.strings.substring (len - 1) 1 s;
        beforeLast = lib.strings.substring 0 (len - 1) s;
      in
        if len > 0 && lastChar == "."
        then beforeLast
        else s;
      resultWithZerosTrimmed = removeTrailingZeroChars floatStr;
      finalResult = removeTrailingDotChar resultWithZerosTrimmed;
    in
      finalResult;
    c = rec {
      x = 0;
      y = 0;
      w = 2880;
      h = 1800;
      name = "eDP-1";
      hz = "@90Hz";
      s = 1.8;
      t = "";
    };
    l = rec {
      x = c.x - h / s;
      y = c.y - w / s / 2.56;
      w = 2560;
      h = 1600;
      name = "DP-1";
      hz = "@60Hz";
      s = 1.6;
      t = ",transform,3";
    };
    t = rec {
      x = c.x;
      y = c.y - c.h / c.s;
      w = 2560;
      h = 1600;
      name = "DP-2";
      hz = "";
      s = 1.6;
      t = "";
    };
    r = rec {
      x = c.x + c.w / c.s;
      y = c.y - h / s / 1.5;
      w = 1920;
      h = 1080;
      name = "DP-4";
      hz = "@60Hz";
      s = 1;
      t = "";
    };
    r2 = rec {
      x = r.x;
      y = r.y;
      w = r.w;
      h = r.h;
      name = "DP-5";
      hz = r.hz;
      s = r.s;
      t = r.t;
    };
    inside_dock = rec {
      x = c.x;
      y = c.y - h / s;
      w = 1920;
      h = 1080;
      name = "desc:Microstep MSI MP273A PB4H784100605";
      hz = "";
      s = 1;
      t = "";
    };
    results = [c l t r r2 inside_dock];
    str = cleanFloatString;
  in
    [
      ",preferred,auto,1"
    ]
    ++ lib.map (m: m.name + "," + str m.w + "x" + str m.h + m.hz + "," + str m.x + "x" + str m.y + "," + str m.s + m.t) results;
}
