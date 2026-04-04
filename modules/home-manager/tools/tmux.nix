{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    escapeTime = 0;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    historyLimit = 50000;
    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ag terminal-overrides ",xterm-kitty:RGB"

      # Catppuccin Mocha colors
      set -g status-style "bg=#1e1e2e,fg=#cdd6f4"
      set -g status-left-length 40
      set -g status-right-length 80

      set -g status-left "#[bg=#b4befe,fg=#1e1e2e,bold]  #S #[bg=#1e1e2e,fg=#b4befe] "
      set -g status-right "#[fg=#585b70]#[bg=#585b70,fg=#cdd6f4]  %H:%M #[bg=#585b70,fg=#89b4fa]#[bg=#89b4fa,fg=#1e1e2e,bold]  %b %d "

      # Window status
      set -g window-status-format "#[fg=#313244]#[bg=#313244,fg=#6c7086] #I  #W #[fg=#313244,bg=#1e1e2e]"
      set -g window-status-current-format "#[fg=#89b4fa]#[bg=#89b4fa,fg=#1e1e2e,bold] #I  #W #[fg=#89b4fa,bg=#1e1e2e]"

      set -g window-status-separator " "
      set -g status-justify centre

      # Pane borders
      set -g pane-border-style "fg=#313244"
      set -g pane-active-border-style "fg=#b4befe"

      # Message style
      set -g message-style "bg=#313244,fg=#cdd6f4"
      set -g message-command-style "bg=#313244,fg=#cdd6f4"

      # Copy mode
      set -g mode-style "bg=#45475a,fg=#cdd6f4"

      # Popup style
      set -g popup-border-style "fg=#585b70"

      # Split keybinds (more intuitive)
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # New windows in current path
      bind c new-window -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
    '';
  };
}
