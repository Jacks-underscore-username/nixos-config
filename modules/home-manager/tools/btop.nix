{...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "catppuccin_mocha";
      theme_background = false;
      truecolor = true;
      rounded_corners = true;
      graph_symbol = "braille";
      shown_boxes = "cpu mem net proc";
      update_ms = 1000;
      proc_sorting = "cpu lazy";
      proc_tree = true;
      proc_gradient = true;
      proc_per_core = false;
      cpu_graph_upper = "Auto";
      cpu_graph_lower = "Auto";
      show_gpu_info = "Auto";
      clock_format = "%H:%M";
      base_10_sizes = false;
      vim_keys = true;
    };
  };
}
