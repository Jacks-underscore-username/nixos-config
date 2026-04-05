{
  config,
  pkgs,
  lib,
  inputs,
  colors,
  ...
}: let
  # Strip "#" prefix for Hyprland's rgb()/rgba() format
  h = c: builtins.replaceStrings ["#"] [""] c;
in {
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
        exec-once = [
          "quickshell"
          "hyprpaperManager"
          "clipse -listen"
        ];
        windowrule =
          [
            "float, class:clipse"
            "size 622 652, class:clipse"
            "rounding 25, class:clipse"
            "float, class:watchWindow"
            "size 622 652, class:watchWindow"
            "rounding 25, class:watchWindow"
            "float, class:org.quickshell"
            "opacity 0.75, class:.*"
          ]
          ++ lib.mapAttrsToList (key: value: "opacity " + lib.strings.floatToString value + ", class:" + key) {
            Minecraft = 1;
            code = 0.9;
            jetbrains-idea-ce = 0.9;
            factorio = 1;
            Mindustry = 1;
            Replicube = 1;
          }
          ++ lib.mapAttrsToList (key: value: "opacity " + lib.strings.floatToString value + ", title:" + key) {
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
        # "plugin:dynamic-cursors" = {
        #   shake.enabled = false;
        #   mode = "rotate";
        #   rotate.length = 10;
        # };
        # windowrule = [
        # "float, class:jetbrains-idea-ce"
        # "fullscreen, class:jetbrains-idea-ce"
        # "size 100 100, class:jetbrains-idea-ce"
        # ];
        monitor = config.hyprland.monitors;
        general = {
          no_focus_fallback = true;
          "col.active_border" = "rgb(${h colors.blue}) rgb(${h colors.magenta}) 45deg";
          "col.inactive_border" = "rgb(${h colors.bg_highlight})";
          border_size = 2;
          gaps_in = 4;
          gaps_out = 8;
        };
        group = {
          "col.border_active" = "rgb(${h colors.blue})";
          "col.border_inactive" = "rgb(${h colors.bg_highlight})";
          "col.border_locked_active" = "rgb(${h colors.orange})";
          "col.border_locked_inactive" = "rgb(${h colors.bg_highlight})";
          groupbar = {
            "col.active" = "rgb(${h colors.blue0})";
            "col.inactive" = "rgb(${h colors.bg_dark})";
            "col.locked_active" = "rgb(${h colors.orange})";
            "col.locked_inactive" = "rgb(${h colors.bg_dark})";
            font_family = "FiraCode Nerd Font";
            font_size = 11;
            text_color = "rgb(${h colors.fg})";
          };
        };
        decoration = {
          rounding = 8;
          shadow = {
            enabled = true;
            range = 12;
            render_power = 3;
            color = "rgba(${h colors.black}66)";
            color_inactive = "rgba(${h colors.black}33)";
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          font_family = "FiraCode Nerd Font";
          animate_manual_resizes = true;
          animate_mouse_windowdragging = true;
          background_color = "rgb(${h colors.bg_dark})";
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
          "SUPER,r,exec,qs ipc --pid $(pgrep -x quickshell) call launcher toggle"
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
