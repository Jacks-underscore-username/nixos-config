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
      # plugins = [pkgs.hyprlandPlugins.hypr-dynamic-cursors];
      settings = {
        layerrule = [
          # "blur, class:waybar"
          # "blur, waybar"
        ];
        exec-once = [
          "waybar"
          "hyprpaperManager"
        ];
        # "plugin:dynamic-cursors" = {
        #   shake.enabled = false;
        #   mode = "rotate";
        #   rotate.length = 10;
        # };
        monitor = config.hyprland.monitors;
        general = {
          no_focus_fallback = true;
        };
        input = {
          touchpad = {
            natural_scroll = true;
          };
        };
        env = [
          "AQ_NO_MODIFIERS,1"
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

          "SUPER,z,exec,cycleWorkspace -1"
          "SUPER,x,exec,cycleWorkspace 1"

          "SUPER,mouse_up,exec,cycleWorkspace -1"
          "SUPER,mouse_down,exec,cycleWorkspace 1"

          "SUPER,n,exec,createWorkspace"

          "SUPER,c,exec,moveWorkspace"
          "SUPER,v,exec,moveWindow"

          "SUPERALT,f,fullscreen"
          "SUPER,f,togglefloating"

          "SUPER,p,exec,peek"

          "SUPERSHIFT,s,exec,grim -g \"$(slurp)\" - |  wl-copy"
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
      };
    };
  };
}
