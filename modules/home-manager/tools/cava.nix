{...}: {
  # Catppuccin Mocha cava config
  xdg.configFile."cava/config".text = ''
    [general]
    framerate = 60
    autosens = 1
    overshoot = 20
    sensitivity = 100
    bars = 0
    bar_width = 2
    bar_spacing = 1

    [input]
    method = pipewire
    source = auto

    [output]
    method = noncurses
    channels = stereo
    mono_option = average

    [smoothing]
    noise_reduction = 77

    [color]
    gradient = 1
    gradient_count = 8
    gradient_color_1 = '#94e2d5'
    gradient_color_2 = '#89dceb'
    gradient_color_3 = '#74c7ec'
    gradient_color_4 = '#89b4fa'
    gradient_color_5 = '#b4befe'
    gradient_color_6 = '#cba6f7'
    gradient_color_7 = '#f5c2e7'
    gradient_color_8 = '#f38ba8'
  '';
}
