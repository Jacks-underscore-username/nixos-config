{colors, ...}: let
  c = colors;
in {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 10000;
    keyMode = "vi";
    escapeTime = 0;
    mouse = true;

    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g default-terminal "tmux-256color"

      set -g status-position bottom
      set -g status-interval 5
      set -g status-justify left

      set -g status-style "fg=${c.fgSubtle},bg=${c.bgPanel}"
      set -g status-left-length 40
      set -g status-right-length 60

      set -g status-left "#[fg=${c.bg},bg=${c.accent},bold] #S #[fg=${c.accent},bg=${c.bgPanel}]"

      set -g status-right "#[fg=${c.indentGuideActive}]│ #[fg=${c.fgSubtle}]%H:%M #[fg=${c.indentGuideActive}]│ #[fg=${c.fgSubtle}]%d %b"

      set -g window-status-format " #[fg=${c.fgMuted}]#I:#W "
      set -g window-status-separator ""

      set -g window-status-current-format "#[fg=${c.accent},bg=${c.bgElevated},bold] #I:#W #[fg=${c.bgElevated},bg=${c.bgPanel}]"

      set -g window-status-activity-style "fg=${c.warning},bg=${c.bgPanel}"
      set -g window-status-bell-style "fg=${c.error},bg=${c.bgPanel},bold"

      set -g pane-border-style "fg=${c.indentGuide}"
      set -g pane-active-border-style "fg=${c.accent}"

      set -g message-style "fg=${c.fg},bg=${c.bgElevated}"
      set -g message-command-style "fg=${c.fg},bg=${c.bgElevated}"

      set -g mode-style "fg=${c.bg},bg=${c.accent}"

      set -g clock-mode-colour "${c.accent}"

      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"
    '';
  };
}
