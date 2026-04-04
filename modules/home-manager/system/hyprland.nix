{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options = {
    hyprland.monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [",preferred,auto,auto"];
      example = [
        ",preferred,auto,auto"
        "monitorName,resolution,offset,scale"
      ];
      description = ''
        List of monitors to be used by hyprland.
      '';
    };
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        exec-once = [
          "waybar"
          "hyprpaperManager"
          "clipse -listen"
          "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
        ];
        windowrule =
          [
            "float, class:clipse"
            "size 622 652, class:clipse"
            "rounding 25, class:clipse"
            "float, class:watchWindow"
            "size 622 652, class:watchWindow"
            "rounding 25, class:watchWindow"
          ]
          ++ lib.mapAttrsToList (key: value: "opacity " + lib.strings.floatToString value + " " + lib.strings.floatToString value + ", class:" + key) {
            code = 0.9;
            jetbrains-idea-ce = 0.9;
            Minecraft = 1;
            factorio = 1;
            Mindustry = 1;
            Replicube = 1;
          }
          ++ lib.mapAttrsToList (key: value: "opacity " + lib.strings.floatToString value + " " + lib.strings.floatToString value + ", title:" + key) {
            ".*YouTube.*" = 1;
            "Cosmoteer" = 1;
            ".*OPAQUE.*" = 1;
            "Celeste" = 1;
            "shapez 2" = 1;
            "Among Us" = 1;
            "R.E.P.O." = 1;
            "REPO" = 1;
            "Minecraft.*" = 1;
            "DDSS" = 1;
            "MTGA" = 1;
            ".*ASTRONEER.*" = 1;
          };
        monitor = config.hyprland.monitors;
        general = {
          no_focus_fallback = true;
          gaps_in = 5;
          gaps_out = 14;
          border_size = 2;
          "col.active_border" = "rgba(b4befeff) rgba(89b4faff) 45deg";
          "col.inactive_border" = "rgba(313244aa)";
          layout = "dwindle";
          allow_tearing = false;
        };
        decoration = {
          rounding = 14;
          active_opacity = 1.0;
          inactive_opacity = 0.92;
          shadow = {
            enabled = true;
            range = 20;
            render_power = 3;
            color = "rgba(1a1a2ecc)";
          };
          blur = {
            enabled = true;
            size = 8;
            passes = 3;
            noise = 1.0e-2;
            contrast = 0.9;
            brightness = 0.8;
            vibrancy = 0.17;
            vibrancy_darkness = 0.0;
            new_optimizations = true;
            xray = false;
            popups = true;
          };
        };
        animations = {
          enabled = true;
          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
            "wind, 0.05, 0.9, 0.1, 1.05"
            "fluent, 0.0, 0.0, 0.2, 1.0"
          ];
          animation = [
            "windows, 1, 5, wind, slide"
            "windowsIn, 1, 5, wind, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "windowsMove, 1, 4, wind, slide"
            "border, 1, 10, default"
            "borderangle, 1, 100, default, loop"
            "fade, 1, 5, smoothIn"
            "fadeDim, 1, 5, smoothIn"
            "workspaces, 1, 5, wind"
          ];
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = false;
        };
        group = {
          "col.border_active" = "rgba(b4befeff)";
          "col.border_inactive" = "rgba(313244aa)";
          groupbar = {
            font_family = "FiraCode Nerd Font";
            font_size = 11;
            gradients = true;
            "col.active" = "rgba(b4befe44)";
            "col.inactive" = "rgba(31324488)";
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = "FiraCode Nerd Font";
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          background_color = "0x1e1e2e";
          vfr = true;
        };
        input = {
          touchpad = {
            natural_scroll = true;
          };
        };
        env = [
          "AQ_NO_MODIFIERS,1"
          "HYPRCURSOR_THEME,catppuccin-mocha-lavender-cursors"
          "HYPRCURSOR_SIZE,28"
          "XCURSOR_SIZE,28"
        ];
        "binds:scroll_event_delay" = 100;
        bind = [
          "SUPER,return,exec,kitty"
          "SUPER,r,exec,wofi --show drun"
          "SUPER,b,exec,google-chrome-stable"

          "SUPER,q,killactive"

          "SUPER,left,movefocus,l"
          "SUPER,down,movefocus,d"
          "SUPER,up,movefocus,u"
          "SUPER,right,movefocus,r"
          "SUPERSHIFT,left,swapwindow,l"
          "SUPERSHIFT,down,swapwindow,d"
          "SUPERSHIFT,up,swapwindow,u"
          "SUPERSHIFT,right,swapwindow,r"
          "SUPERCONTROL,left,movewindow,l"
          "SUPERCONTROL,down,movewindow,d"
          "SUPERCONTROL,up,movewindow,u"
          "SUPERCONTROL,right,movewindow,r"
          "SUPERALT,left,resizeactive,-50 0"
          "SUPERALT,right,resizeactive,50 0"
          "SUPERALT,up,resizeactive,0 -50"
          "SUPERALT,down,resizeactive,0 50"

          ",XF86AudioNext,exec,playerctl next"
          ",XF86AudioPause,exec,playerctl play-pause"
          ",XF86AudioPlay,exec,playerctl play-pause"
          ",XF86AudioPrev,exec,playerctl previous"

          "SUPERALT,s,exec,systemctl suspend"
          "SUPER,escape,exec,hyprlock"

          "SUPER,z,exec,cycleWorkspace -1"
          "SUPER,x,exec,cycleWorkspace 1"

          "SUPER,mouse_up,exec,cycleWorkspace -1"
          "SUPER,mouse_down,exec,cycleWorkspace 1"

          "SUPER,n,exec,createWorkspace"

          "SUPER,c,exec,moveWorkspace"
          "SUPER,v,exec,moveWindow"

          "SUPERALT,f,fullscreen"
          "SUPER,f,togglefloating"

          "SUPER,p,exec,hyprpaperManager"
          "SUPER,l,exec,toggleLightMode"

          "SUPERSHIFT,s,exec,grim -g \"$(slurp)\" - |  wl-copy"
          "SUPERSHIFTCONTROL,s,exec,grim - |  wl-copy"

          "SUPERCONTROL,C,exec,kitty --class clipse -e 'clipse'"
          # <MACRO INSERT>
          "SUPERCONTROLSHIFT,S,exec,screenRecord"
        ];
        binde = [
          # ",z,exec,hyprctl dispatch sendshortcut \",q,title:(.*Factorio.*)\" && sleep 0.01 && hyprctl dispatch sendshortcut \",mouse:272,title:(.*Factorio.*)\" && sleep 0.01 && hyprctl dispatch sendshortcut \",q,title:(.*Factorio.*)\""
        ];
        bindel = [
          ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl s 10%+"
          ",XF86MonBrightnessDown,exec,brightnessctl s 10%-"
        ];
        bindl = [
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
        bindm = [
          "SUPER,mouse:272,movewindow"
          "SUPER,mouse:273,resizewindow"
        ];
        ecosystem = {
          "no_update_news" = true;
        };
      };
    };
  };
}
