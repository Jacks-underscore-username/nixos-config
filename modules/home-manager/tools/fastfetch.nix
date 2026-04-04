{...}: {
  # Fastfetch with Catppuccin Mocha styling
  xdg.configFile."fastfetch/config.jsonc".text = builtins.toJSON {
    "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
    logo = {
      type = "small";
      color = {
        "1" = "blue";
        "2" = "magenta";
      };
    };
    display = {
      separator = "  ";
      color = {
        keys = "blue";
        title = "magenta";
      };
    };
    modules = [
      {
        type = "title";
        format = "{user-name}@{host-name}";
        key = "╭─";
      }
      {
        type = "separator";
        string = "─────────────────────────";
      }
      {
        type = "os";
        key = "│  ";
      }
      {
        type = "kernel";
        key = "│  ";
      }
      {
        type = "packages";
        key = "│  ";
      }
      {
        type = "shell";
        key = "│  ";
      }
      {
        type = "wm";
        key = "│  ";
      }
      {
        type = "terminal";
        key = "│  ";
      }
      {
        type = "cpu";
        key = "│  ";
      }
      {
        type = "gpu";
        key = "│ 󰍹 ";
      }
      {
        type = "memory";
        key = "│ 󰑭 ";
      }
      {
        type = "disk";
        key = "│ 󰋊 ";
      }
      {
        type = "uptime";
        key = "│  ";
      }
      {
        type = "separator";
        string = "─────────────────────────";
      }
      {
        type = "colors";
        key = "╰─";
        symbol = "circle";
      }
    ];
  };
}
