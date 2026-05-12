{
  pkgs,
  colors,
  ...
}: let
  c = colors;

  # Adwaita-dark as the base; our CSS overrides inject inkglow palette
  isDark = c.themeIsDark;

  # Generate a minimal gtk.css that remaps Adwaita colour vars to inkglow
  gtk3Css = ''
    /* ── Inkglow GTK3 theme — generated from lib/colors.nix ── */

    @define-color theme_bg_color ${c.bgPanel};
    @define-color theme_fg_color ${c.fg};
    @define-color theme_base_color ${c.bg};
    @define-color theme_text_color ${c.fg};
    @define-color theme_selected_bg_color ${c.accent};
    @define-color theme_selected_fg_color ${c.bg};
    @define-color theme_unfocused_bg_color ${c.bgPanel};
    @define-color theme_unfocused_fg_color ${c.fgSubtle};
    @define-color theme_unfocused_base_color ${c.bgPanel};
    @define-color theme_unfocused_text_color ${c.fgSubtle};
    @define-color theme_unfocused_selected_bg_color ${c.accentAlt};
    @define-color theme_unfocused_selected_fg_color ${c.fg};
    @define-color theme_button_bg_color ${c.bgHighlight};
    @define-color theme_button_fg_color ${c.fg};
    @define-color insensitive_bg_color ${c.bgDeeper};
    @define-color insensitive_fg_color ${c.fgMuted};
    @define-color insensitive_base_color ${c.bgDeeper};
    @define-color borders ${c.indentGuide};
    @define-color unfocused_borders ${c.indentGuide};
    @define-color warning_color ${c.warning};
    @define-color error_color ${c.error};
    @define-color success_color ${c.success};

    /* Window chrome */
    window, .window-frame {
      background-color: ${c.bgPanel};
      color: ${c.fg};
    }
    .titlebar, headerbar {
      background-color: ${c.bgDeeper};
      color: ${c.fg};
      border-bottom: 1px solid ${c.indentGuide};
    }
    .titlebar button, headerbar button {
      background-color: transparent;
      color: ${c.fgSubtle};
      border: none;
    }
    .titlebar button:hover, headerbar button:hover {
      background-color: ${c.bgHighlight};
      color: ${c.fg};
    }

    /* Sidebar / file manager panels */
    .sidebar, .sidebar-pane, placessidebar {
      background-color: ${c.bgPanel};
      color: ${c.fgSubtle};
    }
    .sidebar row:selected, placessidebar row:selected {
      background-color: ${c.accentAlt};
      color: ${c.fg};
    }
    .sidebar row:hover, placessidebar row:hover {
      background-color: ${c.bgHighlight};
    }

    /* File manager / list views */
    treeview, listview, iconview {
      background-color: ${c.bg};
      color: ${c.fg};
    }
    treeview:selected, listview row:selected, iconview:selected {
      background-color: ${c.accentAlt};
      color: ${c.fg};
    }
    treeview:hover, listview row:hover {
      background-color: ${c.bgHighlight};
    }
    treeview.view header button {
      background-color: ${c.bgPanel};
      color: ${c.fgSubtle};
      border-right: 1px solid ${c.indentGuide};
    }

    /* Text / entries */
    entry {
      background-color: ${c.bgElevated};
      color: ${c.fg};
      caret-color: ${c.accent};
      border: 1px solid ${c.indentGuide};
      border-radius: 4px;
    }
    entry:focus {
      border-color: ${c.accent};
    }

    /* Buttons */
    button {
      background-color: ${c.bgHighlight};
      color: ${c.fg};
      border: 1px solid ${c.indentGuide};
      border-radius: 4px;
    }
    button:hover {
      background-color: ${c.bgVisual};
    }
    button.suggested-action {
      background-color: ${c.accent};
      color: ${c.bg};
    }
    button.suggested-action:hover {
      background-color: ${c.accentAlt};
      color: ${c.bg};
    }
    button.destructive-action {
      background-color: ${c.error};
      color: ${c.bg};
    }

    /* Menus / popovers */
    menu, .menu, popover {
      background-color: ${c.bgPanel};
      color: ${c.fg};
      border: 1px solid ${c.indentGuide};
    }
    menu menuitem:hover, .menu menuitem:hover {
      background-color: ${c.accentAlt};
      color: ${c.fg};
    }
    menubar {
      background-color: ${c.bgDeeper};
      color: ${c.fgSubtle};
    }
    menubar > menuitem:hover {
      background-color: ${c.bgHighlight};
      color: ${c.fg};
    }

    /* Scrollbars */
    scrollbar {
      background-color: ${c.bgPanel};
    }
    scrollbar slider {
      background-color: ${c.indentGuideActive};
      border-radius: 6px;
      min-width: 6px;
      min-height: 6px;
    }
    scrollbar slider:hover {
      background-color: ${c.fgMuted};
    }

    /* Notebook / tabs */
    notebook > header {
      background-color: ${c.bgDeeper};
      border-bottom: 1px solid ${c.indentGuide};
    }
    notebook > header tab {
      color: ${c.fgSubtle};
      padding: 4px 12px;
    }
    notebook > header tab:checked {
      color: ${c.fg};
      background-color: ${c.bgPanel};
      border-top: 2px solid ${c.accent};
    }

    /* Tooltips */
    tooltip {
      background-color: ${c.bgElevated};
      color: ${c.fg};
      border: 1px solid ${c.indentGuide};
    }

    /* Progress / scale */
    progressbar trough { background-color: ${c.bgHighlight}; }
    progressbar progress { background-color: ${c.accent}; }
    scale trough { background-color: ${c.bgHighlight}; }
    scale highlight { background-color: ${c.accent}; }

    /* Check / radio */
    checkbutton check, radiobutton radio {
      background-color: ${c.bgElevated};
      border: 1px solid ${c.indentGuide};
    }
    checkbutton check:checked, radiobutton radio:checked {
      background-color: ${c.accent};
      color: ${c.bg};
    }

    /* Statusbar */
    statusbar {
      background-color: ${c.bgDeeper};
      color: ${c.fgSubtle};
      border-top: 1px solid ${c.indentGuide};
    }

    /* Separators */
    separator {
      background-color: ${c.indentGuide};
    }
  '';

  gtk4Css = ''
    /* ── Inkglow GTK4 theme — generated from lib/colors.nix ── */

    window {
      background-color: ${c.bgPanel};
      color: ${c.fg};
    }
    headerbar {
      background-color: ${c.bgDeeper};
      color: ${c.fg};
    }
    .sidebar {
      background-color: ${c.bgPanel};
    }
    listview {
      background-color: ${c.bg};
      color: ${c.fg};
    }
    listview row:selected {
      background-color: ${c.accentAlt};
      color: ${c.fg};
    }
    listview row:hover {
      background-color: ${c.bgHighlight};
    }
    entry {
      background-color: ${c.bgElevated};
      color: ${c.fg};
    }
    button {
      background-color: ${c.bgHighlight};
      color: ${c.fg};
    }
    button.suggested-action {
      background-color: ${c.accent};
      color: ${c.bg};
    }
    popover {
      background-color: ${c.bgPanel};
      color: ${c.fg};
    }
    menu {
      background-color: ${c.bgPanel};
      color: ${c.fg};
    }
    tooltip {
      background-color: ${c.bgElevated};
      color: ${c.fg};
    }
    progressbar progress {
      background-color: ${c.accent};
    }
    progressbar trough {
      background-color: ${c.bgHighlight};
    }
    separator {
      background-color: ${c.indentGuide};
    }
    scrollbar slider {
      background-color: ${c.indentGuideActive};
    }
    scrollbar slider:hover {
      background-color: ${c.fgMuted};
    }
  '';
in {
  gtk = {
    enable = true;

    theme = {
      # Use Adwaita-dark as the structural base; our CSS overrides the colors
      name = if isDark then "Adwaita-dark" else "Adwaita";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    font = {
      name = "FiraCode Nerd Font";
      size = 11;
    };

    gtk3.extraCss = gtk3Css;
    gtk4.extraCss = gtk4Css;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = isDark;
      gtk-decoration-layout = "close,minimize,maximize:";
    };
  };

  # Set colour scheme preference (used by portals and some Qt apps)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = if isDark then "prefer-dark" else "prefer-light";
      gtk-theme = if isDark then "Adwaita-dark" else "Adwaita";
      icon-theme = "Adwaita";
      font-name = "FiraCode Nerd Font 11";
    };
  };
}
