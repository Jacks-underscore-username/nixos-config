{
  pkgs,
  lib,
  config,
  colors,
  ...
}: let
  c = colors;

  themeFile = builtins.toJSON {
    name = "Tokyo Night (Nix)";
    author = "Generated from lib/colors.nix";
    type = "dark";
    semanticTokenColors = {
      "parameter.declaration" = {foreground = c.yellow;};
      parameter = {foreground = c.fg_param;};
      "property.declaration" = {foreground = c.green1;};
      "property.defaultLibrary" = {foreground = c.blue1;};
      "*.defaultLibrary" = {foreground = c.blue1;};
      "variable.defaultLibrary" = {foreground = c.blue1;};
      "variable.declaration" = {foreground = c.magenta;};
      variable = {foreground = c.fg;};
    };
    semanticClass = "tokyo-night-nix";
    colors = {
      # General
      "foreground" = c.dark5;
      "descriptionForeground" = c.fg_muted;
      "disabledForeground" = c.dark3;
      "focusBorder" = "${c.dark3}33";
      "errorForeground" = c.fg_muted;
      "widget.shadow" = c.none;
      "scrollbar.shadow" = "${c.black}33";
      "badge.background" = "${c.badge_bg}30";
      "badge.foreground" = c.fg_badge;
      "icon.foreground" = c.dark5;
      "settings.headerForeground" = c.git_change;
      "window.activeBorder" = c.bg_window;
      "window.inactiveBorder" = c.bg_window;
      "sash.hoverBorder" = c.sash;

      # Toolbar
      "toolbar.activeBackground" = c.bg_active;
      "toolbar.hoverBackground" = c.bg_active;

      # Extension buttons
      "extensionButton.prominentBackground" = "${c.blue0}DD";
      "extensionButton.prominentHoverBackground" = "${c.blue0}AA";
      "extensionButton.prominentForeground" = c.white;
      "extensionBadge.remoteBackground" = c.blue0;
      "extensionBadge.remoteForeground" = c.white;

      # Buttons
      "button.background" = "${c.blue0}dd";
      "button.hoverBackground" = "${c.blue0}AA";
      "button.secondaryBackground" = c.bg_button_secondary;
      "button.foreground" = c.white;
      "progressBar.background" = c.blue0;

      # Inputs
      "input.background" = c.bg_input;
      "input.foreground" = c.fg_dark;
      "input.border" = c.bg_input_border;
      "input.placeholderForeground" = "${c.dark5}8A";
      "inputOption.activeForeground" = c.fg;
      "inputOption.activeBackground" = "${c.blue0}44";

      "inputValidation.infoForeground" = c.fg_info;
      "inputValidation.infoBackground" = "${c.blue0}5c";
      "inputValidation.infoBorder" = c.blue0;
      "inputValidation.warningForeground" = c.black;
      "inputValidation.warningBackground" = c.warning_bg;
      "inputValidation.warningBorder" = c.yellow;
      "inputValidation.errorForeground" = c.fg_info;
      "inputValidation.errorBackground" = c.error_bg;
      "inputValidation.errorBorder" = c.error_border;

      # Dropdowns
      "dropdown.foreground" = c.dark5;
      "dropdown.background" = c.bg_input;
      "dropdown.listBackground" = c.bg_input;

      # Activity bar
      "activityBar.background" = c.bg_dark;
      "activityBar.foreground" = c.dark5;
      "activityBar.inactiveForeground" = c.fg_gutter;
      "activityBar.border" = c.bg_dark;
      "activityBarBadge.background" = c.blue0;
      "activityBarBadge.foreground" = c.white;
      "activityBarTop.foreground" = c.dark5;
      "activityBarTop.inactiveForeground" = c.fg_gutter;

      # Sidebar
      "tree.indentGuidesStroke" = c.tree_guide;
      "sideBar.foreground" = c.dark5;
      "sideBar.background" = c.bg_dark;
      "sideBar.border" = c.bg_deeper;
      "sideBarTitle.foreground" = c.dark5;
      "sideBarSectionHeader.background" = c.bg_dark;
      "sideBarSectionHeader.foreground" = c.fg_dark;
      "sideBarSectionHeader.border" = c.bg_deeper;
      "sideBar.dropBackground" = c.bg_elevated;

      # Lists
      "list.dropBackground" = c.bg_elevated;
      "list.deemphasizedForeground" = c.dark5;
      "list.activeSelectionBackground" = c.bg_active;
      "list.activeSelectionForeground" = c.fg_dark;
      "list.inactiveSelectionBackground" = c.bg_surface;
      "list.inactiveSelectionForeground" = c.fg_dark;
      "list.focusBackground" = c.bg_surface;
      "list.focusForeground" = c.fg_dark;
      "list.hoverBackground" = "${c.bg_input}";
      "list.hoverForeground" = c.fg_dark;
      "list.highlightForeground" = c.search_highlight;
      "list.invalidItemForeground" = c.invalid_fg;
      "list.errorForeground" = c.error_muted;
      "list.warningForeground" = c.bracket6;
      "listFilterWidget.background" = c.bg_deeper;
      "listFilterWidget.outline" = c.blue0;
      "listFilterWidget.noMatchesOutline" = c.filter_no_match;

      # Picker
      "pickerGroup.foreground" = c.fg_dark;
      "pickerGroup.border" = c.bg_deeper;

      # Scrollbar
      "scrollbarSlider.background" = "${c.scrollbar}15";
      "scrollbarSlider.hoverBackground" = "${c.scrollbar}10";
      "scrollbarSlider.activeBackground" = "${c.scrollbar}22";

      # Bracket highlighting
      "editorBracketHighlight.foreground1" = c.bracket1;
      "editorBracketHighlight.foreground2" = c.bracket2;
      "editorBracketHighlight.foreground3" = c.bracket3;
      "editorBracketHighlight.foreground4" = c.bracket4;
      "editorBracketHighlight.foreground5" = c.bracket5;
      "editorBracketHighlight.foreground6" = c.bracket6;
      "editorBracketHighlight.unexpectedBracket.foreground" = c.red1;

      "editorBracketPairGuide.activeBackground1" = c.bracket1;
      "editorBracketPairGuide.activeBackground2" = c.bracket2;
      "editorBracketPairGuide.activeBackground3" = c.bracket3;
      "editorBracketPairGuide.activeBackground4" = c.bracket4;
      "editorBracketPairGuide.activeBackground5" = c.bracket5;
      "editorBracketPairGuide.activeBackground6" = c.bracket6;

      # Editor
      "selection.background" = "${c.selection}40";
      "editor.background" = c.bg;
      "editor.foreground" = c.fg_dark;
      "editor.foldBackground" = c.bg_fold;
      "editorLink.activeForeground" = c.fg_badge;
      "editor.selectionBackground" = "${c.selection}4d";
      "editor.inactiveSelectionBackground" = "${c.selection}25";
      "editor.findMatchBackground" = "${c.blue0}66";
      "editor.findMatchBorder" = c.yellow;
      "editor.findMatchHighlightBackground" = "${c.blue0}66";
      "editor.findRangeHighlightBackground" = "${c.selection}33";
      "editor.rangeHighlightBackground" = "${c.selection}20";
      "editor.wordHighlightBackground" = "${c.selection}44";
      "editor.wordHighlightStrongBackground" = "${c.selection}55";
      "editor.selectionHighlightBackground" = "${c.selection}44";

      "editorCursor.foreground" = c.fg;
      "editorIndentGuide.background1" = c.indent_guide;
      "editorIndentGuide.activeBackground1" = c.indent_guide_active;
      "editorLineNumber.foreground" = c.indent_guide_active;
      "editorLineNumber.activeForeground" = c.dark5;
      "editor.lineHighlightBackground" = c.bg_elevated;
      "editorWhitespace.foreground" = c.indent_guide_active;

      "editorMarkerNavigation.background" = c.bg_dark;
      "editorHoverWidget.background" = c.bg_dark;
      "editorHoverWidget.border" = c.bg_deeper;

      "editorBracketMatch.background" = c.bg_dark;
      "editorBracketMatch.border" = c.bracket_border;

      # Overview ruler
      "editorOverviewRuler.border" = c.bg_deeper;
      "editorOverviewRuler.errorForeground" = c.red1;
      "editorOverviewRuler.warningForeground" = c.yellow;
      "editorOverviewRuler.infoForeground" = c.teal;
      "editorOverviewRuler.bracketMatchForeground" = c.bg_deeper;
      "editorOverviewRuler.findMatchForeground" = "${c.fg_dark}44";
      "editorOverviewRuler.rangeHighlightForeground" = "${c.fg_dark}44";
      "editorOverviewRuler.selectionHighlightForeground" = "${c.fg_dark}22";
      "editorOverviewRuler.wordHighlightForeground" = "${c.magenta}55";
      "editorOverviewRuler.wordHighlightStrongForeground" = "${c.magenta}66";
      "editorOverviewRuler.modifiedForeground" = c.gutter_modified;
      "editorOverviewRuler.addedForeground" = c.gutter_added;
      "editorOverviewRuler.deletedForeground" = c.gutter_deleted;

      # Editor rulers / diagnostics
      "editorRuler.foreground" = c.bg_deeper;
      "editorError.foreground" = c.red1;
      "editorWarning.foreground" = c.yellow;
      "editorInfo.foreground" = c.info;
      "editorHint.foreground" = c.info;

      # Gutter
      "editorGutter.modifiedBackground" = c.gutter_modified;
      "editorGutter.addedBackground" = c.gutter_added;
      "editorGutter.deletedBackground" = c.gutter_deleted_bg;
      "editorGhostText.foreground" = c.fg_comment_emphasis;

      # Minimap gutter
      "minimapGutter.modifiedBackground" = c.minimap_modified;
      "minimapGutter.addedBackground" = c.minimap_added;
      "minimapGutter.deletedBackground" = c.minimap_deleted;

      # Editor groups
      "editorGroup.border" = c.bg_deeper;
      "editorGroup.dropBackground" = c.bg_elevated;
      "editorGroupHeader.tabsBorder" = c.bg_deeper;
      "editorGroupHeader.tabsBackground" = c.bg_dark;
      "editorGroupHeader.noTabsBackground" = c.bg_dark;
      "editorGroupHeader.border" = c.bg_deeper;
      "editorPane.background" = c.bg;

      # Editor widgets
      "editorWidget.foreground" = c.dark5;
      "editorWidget.background" = c.bg_dark;
      "editorWidget.border" = c.bg_deeper;
      "editorWidget.resizeBorder" = "${c.dark3}33";

      "editorSuggestWidget.background" = c.bg_dark;
      "editorSuggestWidget.border" = c.bg_deeper;
      "editorSuggestWidget.selectedBackground" = c.bg_overlay;
      "editorSuggestWidget.highlightForeground" = c.git_change;

      "editorCodeLens.foreground" = c.fg_comment;
      "editorLightBulb.foreground" = c.yellow;
      "editorLightBulbAutoFix.foreground" = c.yellow;
      "editorInlayHint.foreground" = c.fg_comment_emphasis;

      # Peek view
      "peekView.border" = c.bg_deeper;
      "peekViewEditor.background" = c.bg_dark;
      "peekViewEditor.matchHighlightBackground" = "${c.blue0}66";
      "peekViewTitle.background" = c.bg_deeper;
      "peekViewTitleLabel.foreground" = c.fg_dark;
      "peekViewTitleDescription.foreground" = c.dark5;
      "peekViewResult.background" = c.bg_deeper;
      "peekViewResult.selectionForeground" = c.fg_dark;
      "peekViewResult.selectionBackground" = "${c.blue0}33";
      "peekViewResult.lineForeground" = c.fg_dark;
      "peekViewResult.fileForeground" = c.dark5;
      "peekViewResult.matchHighlightBackground" = "${c.blue0}66";

      # Diff editor
      "diffEditor.insertedTextBackground" = "${c.green2}20";
      "diffEditor.removedTextBackground" = "${c.red1}22";
      "diffEditor.insertedLineBackground" = "${c.green2}20";
      "diffEditor.removedLineBackground" = "${c.red1}22";
      "diffEditorGutter.insertedLineBackground" = "${c.green2}25";
      "diffEditorGutter.removedLineBackground" = "${c.red1}22";
      "diffEditorOverview.insertedForeground" = "${c.green2}25";
      "diffEditorOverview.removedForeground" = "${c.red1}22";
      "diffEditor.diagonalFill" = c.bg_highlight;
      "diffEditor.unchangedCodeBackground" = "${c.bg_diff_unchanged}66";

      "multiDiffEditor.headerBackground" = c.bg;
      "multiDiffEditor.border" = c.bg;

      # Breadcrumbs
      "breadcrumb.background" = c.bg_dark;
      "breadcrumbPicker.background" = c.bg_dark;
      "breadcrumb.foreground" = c.fg_muted;
      "breadcrumb.focusForeground" = c.fg_dark;
      "breadcrumb.activeSelectionForeground" = c.fg_dark;

      # Tabs
      "tab.activeBackground" = c.bg_dark;
      "tab.inactiveBackground" = c.bg_dark;
      "tab.activeForeground" = c.fg_dark;
      "tab.hoverForeground" = c.fg_dark;
      "tab.activeBorder" = c.blue0;
      "tab.inactiveForeground" = c.dark5;
      "tab.border" = c.bg_deeper;
      "tab.unfocusedActiveForeground" = c.fg_dark;
      "tab.unfocusedInactiveForeground" = c.dark5;
      "tab.unfocusedHoverForeground" = c.fg_dark;
      "tab.activeModifiedBorder" = c.bg;
      "tab.inactiveModifiedBorder" = c.bg_tab_modified;
      "tab.unfocusedActiveBorder" = c.bg_tab_modified;
      "tab.lastPinnedBorder" = c.bg_tab_pinned;

      # Panel
      "panel.background" = c.bg_dark;
      "panel.border" = c.bg_deeper;
      "panelTitle.activeForeground" = c.dark5;
      "panelTitle.inactiveForeground" = c.bracket_border;
      "panelTitle.activeBorder" = c.bg_dark;
      "panelInput.border" = c.bg_dark;

      # Status bar
      "statusBar.foreground" = c.dark5;
      "statusBar.background" = c.bg_dark;
      "statusBar.border" = c.bg_deeper;
      "statusBar.noFolderBackground" = c.bg_dark;
      "statusBar.debuggingBackground" = c.bg_dark;
      "statusBar.debuggingForeground" = c.dark5;
      "statusBarItem.activeBackground" = c.bg_deeper;
      "statusBarItem.hoverBackground" = c.bg_overlay;
      "statusBarItem.prominentBackground" = c.bg_deeper;
      "statusBarItem.prominentHoverBackground" = c.bg_overlay;

      # Title bar
      "titleBar.activeForeground" = c.dark5;
      "titleBar.inactiveForeground" = c.dark5;
      "titleBar.activeBackground" = c.bg_dark;
      "titleBar.inactiveBackground" = c.bg_dark;
      "titleBar.border" = c.bg_deeper;

      # Misc UI
      "walkThrough.embeddedEditorBackground" = c.bg_dark;
      "textLink.foreground" = c.git_change;
      "textLink.activeForeground" = c.cyan;
      "textPreformat.foreground" = c.fg_preformat;
      "textBlockQuote.background" = c.bg_dark;
      "textCodeBlock.background" = c.bg_dark;
      "textSeparator.foreground" = c.indent_guide_active;

      # Debug
      "debugExceptionWidget.border" = c.error_border;
      "debugExceptionWidget.background" = c.bg_deeper;
      "debugToolBar.background" = c.bg_deeper;
      "debugConsole.infoForeground" = c.dark5;
      "debugConsole.errorForeground" = c.error_muted;
      "debugConsole.sourceForeground" = c.dark5;
      "debugConsole.warningForeground" = c.bracket6;
      "debugConsoleInputIcon.foreground" = c.green1;
      "editor.stackFrameHighlightBackground" = "${c.stack_frame_highlight}20";
      "editor.focusedStackFrameHighlightBackground" = "${c.green1}20";
      "debugView.stateLabelForeground" = c.dark5;
      "debugView.stateLabelBackground" = c.bg_input;
      "debugView.valueChangedHighlight" = "${c.blue0}aa";
      "debugTokenExpression.name" = c.cyan;
      "debugTokenExpression.value" = c.fg_token;
      "debugTokenExpression.string" = c.green;
      "debugTokenExpression.boolean" = c.orange;
      "debugTokenExpression.number" = c.orange;
      "debugTokenExpression.error" = c.error_muted;
      "debugIcon.breakpointForeground" = c.red1;
      "debugIcon.breakpointDisabledForeground" = c.breakpoint_disabled;
      "debugIcon.breakpointUnverifiedForeground" = c.breakpoint_unverified;

      # Terminal
      "terminal.background" = c.bg_dark;
      "terminal.foreground" = c.dark5;
      "terminal.selectionBackground" = "${c.selection}4d";
      "terminal.ansiBlack" = c.ansi_black;
      "terminal.ansiRed" = c.red;
      "terminal.ansiGreen" = c.green1;
      "terminal.ansiYellow" = c.yellow;
      "terminal.ansiBlue" = c.blue;
      "terminal.ansiMagenta" = c.magenta;
      "terminal.ansiCyan" = c.cyan;
      "terminal.ansiWhite" = c.dark5;
      "terminal.ansiBrightBlack" = c.ansi_black;
      "terminal.ansiBrightRed" = c.red;
      "terminal.ansiBrightGreen" = c.green1;
      "terminal.ansiBrightYellow" = c.yellow;
      "terminal.ansiBrightBlue" = c.blue;
      "terminal.ansiBrightMagenta" = c.magenta;
      "terminal.ansiBrightCyan" = c.cyan;
      "terminal.ansiBrightWhite" = c.fg_badge;

      # Git decorations
      "gitDecoration.modifiedResourceForeground" = c.git_change;
      "gitDecoration.ignoredResourceForeground" = c.fg_muted;
      "gitDecoration.deletedResourceForeground" = c.git_delete;
      "gitDecoration.renamedResourceForeground" = c.git_add;
      "gitDecoration.addedResourceForeground" = c.git_add;
      "gitDecoration.untrackedResourceForeground" = c.git_add;
      "gitDecoration.conflictingResourceForeground" = "${c.yellow}cc";
      "gitDecoration.stageDeletedResourceForeground" = c.git_delete;
      "gitDecoration.stageModifiedResourceForeground" = c.git_change;

      # Notebook
      "notebook.editorBackground" = c.bg;
      "notebook.cellEditorBackground" = c.bg_dark;
      "notebook.cellBorderColor" = c.bg_deeper;
      "notebook.focusedCellBorder" = c.sash;
      "notebook.cellStatusBarItemHoverBackground" = c.bg_surface;

      # Charts
      "charts.red" = c.red;
      "charts.blue" = c.blue;
      "charts.yellow" = c.yellow;
      "charts.orange" = c.orange;
      "charts.green" = c.green2;
      "charts.purple" = c.purple;
      "charts.foreground" = c.fg_token;
      "charts.lines" = c.bg_dark;

      # SCM graph
      "scmGraph.foreground1" = c.orange;
      "scmGraph.foreground2" = c.yellow;
      "scmGraph.foreground3" = c.green2;
      "scmGraph.foreground4" = c.blue;
      "scmGraph.foreground5" = c.magenta;
      "scmGraph.historyItemHoverAdditionsForeground" = c.green2;
      "scmGraph.historyItemHoverDeletionsForeground" = c.red;

      # Merge
      "merge.currentHeaderBackground" = "${c.green2}25";
      "merge.currentContentBackground" = "${c.merge_current}44";
      "merge.incomingHeaderBackground" = "${c.blue0}aa";
      "merge.incomingContentBackground" = "${c.blue0}44";

      # Notifications
      "notificationCenterHeader.background" = c.bg_deeper;
      "notifications.background" = c.bg_deeper;
      "notificationLink.foreground" = c.git_change;
      "notificationsErrorIcon.foreground" = c.error_muted;
      "notificationsWarningIcon.foreground" = c.warning_muted;
      "notificationsInfoIcon.foreground" = c.info;

      # Menus
      "menubar.selectionForeground" = c.fg_dark;
      "menubar.selectionBackground" = c.bg_elevated;
      "menubar.selectionBorder" = c.bg_menu_selection_border;
      "menu.foreground" = c.dark5;
      "menu.background" = c.bg_dark;
      "menu.selectionForeground" = c.fg_dark;
      "menu.selectionBackground" = c.bg_elevated;
      "menu.separatorBackground" = c.bg_deeper;
      "menu.border" = c.bg_deeper;

      # Chat / inline chat
      "chat.requestBorder" = c.bg_input_border;
      "chat.avatarBackground" = c.blue0;
      "chat.avatarForeground" = c.fg_dark;
      "chat.slashCommandBackground" = c.bg_input;
      "chat.slashCommandForeground" = c.blue;
      "inlineChat.foreground" = c.fg_dark;
      "inlineChatInput.background" = c.bg_input;
      "inlineChatDiff.inserted" = "${c.green2}40";
      "inlineChatDiff.removed" = "${c.red1}42";
    };
    tokenColors = [
      {
        name = "Italics - Comments, Storage, Keyword Flow, Decorators";
        scope = [
          "comment"
          "meta.var.expr storage.type"
          "keyword.control.flow"
          "keyword.control.return"
          "meta.directive.vue punctuation.separator.key-value.html"
          "meta.directive.vue entity.other.attribute-name.html"
          "tag.decorator.js entity.name.tag.js"
          "tag.decorator.js punctuation.definition.tag.js"
          "storage.modifier"
          "string.quoted.docstring.multi"
          "string.quoted.docstring.multi.python punctuation.definition.string.begin"
          "string.quoted.docstring.multi.python punctuation.definition.string.end"
          "string.quoted.docstring.multi.python constant.character.escape"
        ];
        settings.fontStyle = "italic";
      }
      {
        name = "Fix YAML block scalar, Python Logical";
        scope = [
          "keyword.control.flow.block-scalar.literal"
          "keyword.control.flow.python"
        ];
        settings.fontStyle = "";
      }
      {
        name = "Comment";
        scope = [
          "comment"
          "comment.block.documentation"
          "punctuation.definition.comment"
          "comment.block.documentation punctuation"
          "string.quoted.docstring.multi"
          "string.quoted.docstring.multi.python punctuation.definition.string.begin"
          "string.quoted.docstring.multi.python punctuation.definition.string.end"
          "string.quoted.docstring.multi.python constant.character.escape"
        ];
        settings.foreground = c.fg_comment;
      }
      {
        name = "Comment Doc";
        scope = [
          "keyword.operator.assignment.jsdoc"
          "comment.block.documentation variable"
          "comment.block.documentation storage"
          "comment.block.documentation keyword"
          "comment.block.documentation support"
          "comment.block.documentation markup"
          "comment.block.documentation markup.inline.raw.string.markdown"
          "meta.other.type.phpdoc.php keyword.other.type.php"
          "meta.other.type.phpdoc.php support.other.namespace.php"
          "meta.other.type.phpdoc.php punctuation.separator.inheritance.php"
          "meta.other.type.phpdoc.php support.class"
          "keyword.other.phpdoc.php"
          "log.date"
        ];
        settings.foreground = c.fg_comment_doc;
      }
      {
        name = "Comment Doc Emphasized";
        scope = [
          "meta.other.type.phpdoc.php support.class"
          "comment.block.documentation storage.type"
          "comment.block.documentation punctuation.definition.block.tag"
          "comment.block.documentation entity.name.type.instance"
        ];
        settings.foreground = c.fg_comment_emphasis;
      }
      {
        name = "Number, Boolean, Undefined, Null";
        scope = [
          "variable.other.constant"
          "punctuation.definition.constant"
          "constant.language"
          "constant.numeric"
          "support.constant"
          "constant.other.caps"
        ];
        settings.foreground = c.orange;
      }
      {
        name = "String, Symbols";
        scope = [
          "string"
          "constant.other.symbol"
          "constant.other.key"
          "meta.attribute-selector"
          "string constant.character"
        ];
        settings = {
          fontStyle = "";
          foreground = c.green;
        };
      }
      {
        name = "Colors";
        scope = [
          "constant.other.color"
          "constant.other.color.rgb-value.hex punctuation.definition.constant"
        ];
        settings.foreground = c.fg_token;
      }
      {
        name = "Invalid";
        scope = ["invalid" "invalid.illegal"];
        settings.foreground = c.invalid;
      }
      {
        name = "Invalid deprecated";
        scope = "invalid.deprecated";
        settings.foreground = c.magenta;
      }
      {
        name = "Storage Type";
        scope = "storage.type";
        settings.foreground = c.magenta;
      }
      {
        name = "Storage - modifier, var, const, let";
        scope = [
          "meta.var.expr storage.type"
          "storage.modifier"
        ];
        settings.foreground = c.purple;
      }
      {
        name = "Interpolation, PHP tags, Smarty tags";
        scope = [
          "punctuation.definition.template-expression"
          "punctuation.section.embedded"
          "meta.embedded.line.tag.smarty"
          "support.constant.handlebars"
          "punctuation.section.tag.twig"
        ];
        settings.foreground = c.cyan;
      }
      {
        name = "Blade, Twig, Smarty Handlebars keywords";
        scope = [
          "keyword.control.smarty"
          "keyword.control.twig"
          "support.constant.handlebars keyword.control"
          "keyword.operator.comparison.twig"
          "keyword.blade"
          "entity.name.function.blade"
        ];
        settings.foreground = c.blue2;
      }
      {
        name = "Spread";
        scope = [
          "keyword.operator.spread"
          "keyword.operator.rest"
        ];
        settings = {
          foreground = c.red;
          fontStyle = "bold";
        };
      }
      {
        name = "Operator, Misc";
        scope = [
          "keyword.operator"
          "keyword.control.as"
          "keyword.other"
          "keyword.operator.bitwise.shift"
          "punctuation"
          "expression.embbeded.vue punctuation.definition.tag"
          "text.html.twig meta.tag.inline.any.html"
          "meta.tag.template.value.twig meta.function.arguments.twig"
          "meta.directive.vue punctuation.separator.key-value.html"
          "punctuation.definition.constant.markdown"
          "punctuation.definition.string"
          "punctuation.support.type.property-name"
          "text.html.vue-html meta.tag"
          "meta.attribute.directive"
          "punctuation.definition.keyword"
          "punctuation.terminator.rule"
          "punctuation.definition.entity"
          "punctuation.separator.inheritance.php"
          "keyword.other.template"
          "keyword.other.substitution"
          "entity.name.operator"
          "meta.property-list punctuation.separator.key-value"
          "meta.at-rule.mixin punctuation.separator.key-value"
          "meta.at-rule.function variable.parameter.url"
        ];
        settings.foreground = c.blue5;
      }
      {
        name = "Import, Export, From, Default";
        scope = [
          "keyword.control.module.js"
          "keyword.control.import"
          "keyword.control.export"
          "keyword.control.from"
          "keyword.control.default"
          "meta.import keyword.other"
        ];
        settings.foreground = c.cyan;
      }
      {
        name = "Keyword";
        scope = [
          "keyword"
          "keyword.control"
          "keyword.other.important"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "Keyword SQL";
        scope = "keyword.other.DML";
        settings.foreground = c.cyan;
      }
      {
        name = "Keyword Operator Logical, Arrow, Ternary, Comparison";
        scope = [
          "keyword.operator.logical"
          "storage.type.function"
          "keyword.operator.bitwise"
          "keyword.operator.ternary"
          "keyword.operator.comparison"
          "keyword.operator.relational"
          "keyword.operator.or.regexp"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "Tag";
        scope = "entity.name.tag";
        settings.foreground = c.red;
      }
      {
        name = "Tag - Custom / Unrecognized";
        scope = [
          "entity.name.tag support.class.component"
          "meta.tag.custom entity.name.tag"
          "meta.tag.other.unrecognized.html.derivative entity.name.tag"
          "meta.tag"
        ];
        settings.foreground = c.tag_custom;
      }
      {
        name = "Tag Punctuation";
        scope = ["punctuation.definition.tag"];
        settings.foreground = c.tag_punctuation;
      }
      {
        name = "Globals, PHP Constants, etc";
        scope = [
          "constant.other.php"
          "variable.other.global.safer"
          "variable.other.global.safer punctuation.definition.variable"
          "variable.other.global"
          "variable.other.global punctuation.definition.variable"
          "constant.other"
        ];
        settings.foreground = c.yellow;
      }
      {
        name = "Variables";
        scope = [
          "variable"
          "support.variable"
          "string constant.other.placeholder"
          "variable.parameter.handlebars"
          "variable.other.object"
          "meta.fstring"
          "meta.function-call meta.function-call.arguments"
        ];
        settings.foreground = c.fg;
      }
      {
        name = "Variable Array Key";
        scope = "meta.array.literal variable";
        settings.foreground = c.cyan;
      }
      {
        name = "Object Key";
        scope = [
          "meta.object-literal.key"
          "entity.name.type.hcl"
          "string.alias.graphql"
          "string.unquoted.graphql"
          "string.unquoted.alias.graphql"
          "meta.group.braces.curly constant.other.object.key.js string.unquoted.label.js"
          "meta.field.declaration.ts variable.object.property"
          "meta.block entity.name.label"
        ];
        settings.foreground = c.green1;
      }
      {
        name = "Object Property";
        scope = [
          "variable.other.property"
          "support.variable.property"
          "support.variable.property.dom"
          "meta.function-call variable.other.object.property"
        ];
        settings.foreground = c.cyan;
      }
      {
        name = "Object Property (own)";
        scope = "variable.other.object.property";
        settings.foreground = c.fg;
      }
      {
        name = "Object Literal Member lvl 3 (Vue Prop Validation)";
        scope = "meta.objectliteral meta.object.member meta.objectliteral meta.object.member meta.objectliteral meta.object.member meta.object-literal.key";
        settings.foreground = c.green2;
      }
      {
        name = "C-related Block Level Variables";
        scope = "source.cpp meta.block variable.other";
        settings.foreground = c.red;
      }
      {
        name = "Other Variable";
        scope = "support.other.variable";
        settings.foreground = c.red;
      }
      {
        name = "Methods";
        scope = [
          "meta.class-method.js entity.name.function.js"
          "entity.name.method.js"
          "variable.function.constructor"
          "keyword.other.special-method"
          "storage.type.cs"
        ];
        settings.foreground = c.blue;
      }
      {
        name = "Function Definition";
        scope = [
          "entity.name.function"
          "variable.other.enummember"
          "meta.function-call"
          "meta.function-call entity.name.function"
          "variable.function"
          "meta.definition.method entity.name.function"
          "meta.object-literal entity.name.function"
        ];
        settings.foreground = c.blue;
      }
      {
        name = "Function Argument";
        scope = [
          "variable.parameter.function.language.special"
          "variable.parameter"
          "meta.function.parameters punctuation.definition.variable"
          "meta.function.parameter variable"
        ];
        settings.foreground = c.yellow;
      }
      {
        name = "Constant, Tag Attribute";
        scope = [
          "keyword.other.type.php"
          "storage.type.php"
          "constant.character"
          "constant.escape"
          "keyword.other.unit"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "Variable Definition";
        scope = [
          "meta.definition.variable variable.other.constant"
          "meta.definition.variable variable.other.readwrite"
          "variable.declaration.hcl variable.other.readwrite.hcl"
          "meta.mapping.key.hcl variable.other.readwrite.hcl"
          "variable.other.declaration"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "Inherited Class";
        scope = "entity.other.inherited-class";
        settings = {
          fontStyle = "";
          foreground = c.magenta;
        };
      }
      {
        name = "Class, Support, DOM, etc";
        scope = [
          "support.class"
          "support.type"
          "variable.other.readwrite.alias"
          "support.orther.namespace.use.php"
          "meta.use.php"
          "support.other.namespace.php"
          "support.type.sys-types"
          "support.variable.dom"
          "support.constant.math"
          "support.type.object.module"
          "support.constant.json"
          "entity.name.namespace"
          "meta.import.qualifier"
          "variable.other.constant.object"
        ];
        settings.foreground = c.blue2;
      }
      {
        name = "Class Name";
        scope = "entity.name";
        settings.foreground = c.fg;
      }
      {
        name = "Support Function";
        scope = "support.function";
        settings.foreground = c.blue2;
      }
      {
        name = "CSS Class and Support";
        scope = [
          "source.css support.type.property-name"
          "source.sass support.type.property-name"
          "source.scss support.type.property-name"
          "source.less support.type.property-name"
          "source.stylus support.type.property-name"
          "source.postcss support.type.property-name"
          "support.type.property-name.css"
          "support.type.vendored.property-name"
          "support.type.map.key"
        ];
        settings.foreground = c.blue;
      }
      {
        name = "CSS Font";
        scope = [
          "support.constant.font-name"
          "meta.definition.variable"
        ];
        settings.foreground = c.green;
      }
      {
        name = "CSS Class";
        scope = [
          "entity.other.attribute-name.class"
          "meta.at-rule.mixin.scss entity.name.function.scss"
        ];
        settings.foreground = c.green;
      }
      {
        name = "CSS ID";
        scope = "entity.other.attribute-name.id";
        settings.foreground = c.css_id;
      }
      {
        name = "CSS Tag";
        scope = "entity.name.tag.css";
        settings.foreground = c.blue2;
      }
      {
        name = "CSS Tag Reference, Pseudo & Class Punctuation";
        scope = [
          "entity.other.attribute-name.pseudo-class punctuation.definition.entity"
          "entity.other.attribute-name.pseudo-element punctuation.definition.entity"
          "entity.other.attribute-name.class punctuation.definition.entity"
          "entity.name.tag.reference"
        ];
        settings.foreground = c.yellow;
      }
      {
        name = "CSS Punctuation";
        scope = "meta.property-list";
        settings.foreground = c.css_punctuation;
      }
      {
        name = "CSS at-rule fix";
        scope = [
          "meta.property-list meta.at-rule.if"
          "meta.at-rule.return variable.parameter.url"
          "meta.property-list meta.at-rule.else"
        ];
        settings.foreground = c.orange;
      }
      {
        name = "CSS Parent Selector Entity";
        scope = ["entity.other.attribute-name.parent-selector-suffix punctuation.definition.entity.css"];
        settings.foreground = c.green1;
      }
      {
        name = "CSS Punctuation comma fix";
        scope = "meta.property-list meta.property-list";
        settings.foreground = c.css_punctuation;
      }
      {
        name = "SCSS @";
        scope = [
          "meta.at-rule.mixin keyword.control.at-rule.mixin"
          "meta.at-rule.include entity.name.function.scss"
          "meta.at-rule.include keyword.control.at-rule.include"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "SCSS Mixins, Extends, Include Keyword";
        scope = [
          "keyword.control.at-rule.include punctuation.definition.keyword"
          "keyword.control.at-rule.mixin punctuation.definition.keyword"
          "meta.at-rule.include keyword.control.at-rule.include"
          "keyword.control.at-rule.extend punctuation.definition.keyword"
          "meta.at-rule.extend keyword.control.at-rule.extend"
          "entity.other.attribute-name.placeholder.css punctuation.definition.entity.css"
          "meta.at-rule.media keyword.control.at-rule.media"
          "meta.at-rule.mixin keyword.control.at-rule.mixin"
          "meta.at-rule.function keyword.control.at-rule.function"
          "keyword.control punctuation.definition.keyword"
        ];
        settings.foreground = c.purple;
      }
      {
        name = "SCSS Include Mixin Argument";
        scope = "meta.property-list meta.at-rule.include";
        settings.foreground = c.fg;
      }
      {
        name = "CSS value";
        scope = "support.constant.property-value";
        settings.foreground = c.orange;
      }
      {
        name = "Sub-methods";
        scope = [
          "entity.name.module.js"
          "variable.import.parameter.js"
          "variable.other.class.js"
        ];
        settings.foreground = c.fg;
      }
      {
        name = "Language methods";
        scope = "variable.language";
        settings.foreground = c.red;
      }
      {
        name = "Variable punctuation";
        scope = "variable.other punctuation.definition.variable";
        settings.foreground = c.fg;
      }
      {
        name = "Keyword this with Punctuation, ES7 Bind Operator";
        scope = [
          "source.js constant.other.object.key.js string.unquoted.label.js"
          "variable.language.this punctuation.definition.variable"
          "keyword.other.this"
        ];
        settings.foreground = c.red;
      }
      {
        name = "HTML Attributes";
        scope = [
          "entity.other.attribute-name"
          "text.html.basic entity.other.attribute-name.html"
          "text.html.basic entity.other.attribute-name"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "HTML Character Entity";
        scope = "text.html constant.character.entity";
        settings.foreground = c.blue2;
      }
      {
        name = "CSS psuedo selectors";
        scope = [
          "entity.other.attribute-name.pseudo-class"
          "entity.other.attribute-name.pseudo-element"
          "entity.other.attribute-name.placeholder"
          "meta.property-list meta.property-value"
        ];
        settings.foreground = c.magenta;
      }
      {
        name = "Inserted";
        scope = "markup.inserted";
        settings.foreground = c.git_add;
      }
      {
        name = "Deleted";
        scope = "markup.deleted";
        settings.foreground = c.git_delete;
      }
      {
        name = "Changed";
        scope = "markup.changed";
        settings.foreground = c.git_change;
      }
      {
        name = "Regular Expressions";
        scope = "string.regexp";
        settings.foreground = c.blue6;
      }
      {
        name = "Regular Expressions - Punctuation";
        scope = "punctuation.definition.group";
        settings.foreground = c.red;
      }
      {
        name = "Regular Expressions - Character Class";
        scope = ["constant.other.character-class.regexp"];
        settings.foreground = c.magenta;
      }
      {
        name = "Regular Expressions - Character Class Set";
        scope = [
          "constant.other.character-class.set.regexp"
          "punctuation.definition.character-class.regexp"
        ];
        settings.foreground = c.yellow;
      }
      {
        name = "Regular Expressions - Quantifier";
        scope = "keyword.operator.quantifier.regexp";
        settings.foreground = c.blue5;
      }
      {
        name = "Regular Expressions - Backslash";
        scope = "constant.character.escape.backslash";
        settings.foreground = c.fg;
      }
      {
        name = "Escape Characters";
        scope = "constant.character.escape";
        settings.foreground = c.blue5;
      }
      {
        name = "Decorators";
        scope = [
          "tag.decorator.js entity.name.tag.js"
          "tag.decorator.js punctuation.definition.tag.js"
        ];
        settings.foreground = c.blue;
      }
      {
        name = "CSS Units";
        scope = "keyword.other.unit";
        settings.foreground = c.red;
      }
      {
        name = "JSON Key - Level 0";
        scope = ["source.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.blue;
      }
      {
        name = "JSON Key - Level 1";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.blue2;
      }
      {
        name = "JSON Key - Level 2";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.cyan;
      }
      {
        name = "JSON Key - Level 3";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.magenta;
      }
      {
        name = "JSON Key - Level 4";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.yellow;
      }
      {
        name = "JSON Key - Level 5";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.blue2;
      }
      {
        name = "JSON Key - Level 6";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.green1;
      }
      {
        name = "JSON Key - Level 7";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.red;
      }
      {
        name = "JSON Key - Level 8";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.green;
      }
      {
        name = "Plain Punctuation";
        scope = "punctuation.definition.list_item.markdown";
        settings.foreground = c.css_punctuation;
      }
      {
        name = "Block Punctuation";
        scope = [
          "meta.block"
          "meta.brace"
          "punctuation.definition.block"
          "punctuation.definition.use"
          "punctuation.definition.class"
          "punctuation.definition.begin.bracket"
          "punctuation.definition.end.bracket"
          "punctuation.definition.switch-expression.begin.bracket"
          "punctuation.definition.switch-expression.end.bracket"
          "punctuation.definition.section.switch-block.begin.bracket"
          "punctuation.definition.section.switch-block.end.bracket"
          "punctuation.definition.group.shell"
          "punctuation.definition.parameters"
          "punctuation.definition.arguments"
          "punctuation.definition.dictionary"
          "punctuation.definition.array"
          "punctuation.section"
        ];
        settings.foreground = c.css_punctuation;
      }
      {
        name = "Markdown - Plain";
        scope = ["meta.embedded.block"];
        settings.foreground = c.fg;
      }
      {
        name = "HTML text";
        scope = [
          "meta.tag JSXNested"
          "meta.jsx.children"
          "text.html"
          "text.log"
        ];
        settings.foreground = c.fg_token;
      }
      {
        name = "Markdown - Markup Raw Inline";
        scope = "text.html.markdown markup.inline.raw.markdown";
        settings.foreground = c.magenta;
      }
      {
        name = "Markdown - Markup Raw Inline Punctuation";
        scope = "text.html.markdown markup.inline.raw.markdown punctuation.definition.raw.markdown";
        settings.foreground = c.md_raw_punctuation;
      }
      {
        name = "Markdown - Heading 1";
        scope = [
          "heading.1.markdown entity.name"
          "heading.1.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.blue5;
        };
      }
      {
        name = "Markdown - Heading 2";
        scope = [
          "heading.2.markdown entity.name"
          "heading.2.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.md_h2;
        };
      }
      {
        name = "Markdown - Heading 3";
        scope = [
          "heading.3.markdown entity.name"
          "heading.3.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.blue;
        };
      }
      {
        name = "Markdown - Heading 4";
        scope = [
          "heading.4.markdown entity.name"
          "heading.4.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.md_h4;
        };
      }
      {
        name = "Markdown - Heading 5";
        scope = [
          "heading.5.markdown entity.name"
          "heading.5.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.fg_token;
        };
      }
      {
        name = "Markdown - Heading 6";
        scope = [
          "heading.6.markdown entity.name"
          "heading.6.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.md_h6;
        };
      }
      {
        name = "Markup - Italic";
        scope = ["markup.italic" "markup.italic punctuation"];
        settings = {
          fontStyle = "italic";
          foreground = c.fg;
        };
      }
      {
        name = "Markup - Bold";
        scope = ["markup.bold" "markup.bold punctuation"];
        settings = {
          fontStyle = "bold";
          foreground = c.fg;
        };
      }
      {
        name = "Markup - Bold-Italic";
        scope = ["markup.bold markup.italic" "markup.bold markup.italic punctuation"];
        settings = {
          fontStyle = "bold italic";
          foreground = c.fg;
        };
      }
      {
        name = "Markup - Underline";
        scope = ["markup.underline" "markup.underline punctuation"];
        settings.fontStyle = "underline";
      }
      {
        name = "Markdown - Blockquote";
        scope = "markup.quote punctuation.definition.blockquote.markdown";
        settings.foreground = c.md_raw_punctuation;
      }
      {
        name = "Markup - Quote";
        scope = "markup.quote";
        settings.fontStyle = "italic";
      }
      {
        name = "Markdown - Link";
        scope = [
          "string.other.link"
          "markup.underline.link"
          "constant.other.reference.link.markdown"
          "string.other.link.description.title.markdown"
        ];
        settings.foreground = c.green1;
      }
      {
        name = "Markdown - Fenced Code Block";
        scope = [
          "markup.fenced_code.block.markdown"
          "markup.inline.raw.string.markdown"
          "variable.language.fenced.markdown"
        ];
        settings.foreground = c.blue5;
      }
      {
        name = "Markdown - Separator";
        scope = "meta.separator";
        settings = {
          fontStyle = "bold";
          foreground = c.fg_comment;
        };
      }
      {
        name = "Markup - Table";
        scope = "markup.table";
        settings.foreground = c.markup_table;
      }
      {
        name = "Token - Info";
        scope = "token.info-token";
        settings.foreground = c.blue2;
      }
      {
        name = "Token - Warn";
        scope = "token.warn-token";
        settings.foreground = c.token_warn;
      }
      {
        name = "Token - Error";
        scope = "token.error-token";
        settings.foreground = c.red1;
      }
      {
        name = "Token - Debug";
        scope = "token.debug-token";
        settings.foreground = c.token_debug;
      }
      {
        name = "Apache Tag";
        scope = "entity.tag.apacheconf";
        settings.foreground = c.red;
      }
      {
        name = "Preprocessor";
        scope = ["meta.preprocessor"];
        settings.foreground = c.green1;
      }
      {
        name = "ENV value";
        scope = "source.env";
        settings.foreground = c.blue;
      }
    ];
  };

  # Build a VS Code extension package containing the theme
  tokyoNightThemeExtension = pkgs.stdenvNoCC.mkDerivation {
    pname = "tokyo-night-nix-theme";
    version = "1.0.0";
    dontUnpack = true;

    passthru = {
      vscodeExtPublisher = "nix";
      vscodeExtName = "tokyo-night-nix";
      vscodeExtUniqueId = "nix.tokyo-night-nix";
    };

    buildPhase = ''
      mkdir -p $out/share/vscode/extensions/nix.tokyo-night-nix/themes
      cat > $out/share/vscode/extensions/nix.tokyo-night-nix/package.json << 'MANIFEST'
      {
        "name": "tokyo-night-nix",
        "displayName": "Tokyo Night (Nix)",
        "version": "1.0.0",
        "publisher": "nix",
        "engines": { "vscode": "^1.50.0" },
        "categories": ["Themes"],
        "contributes": {
          "themes": [
            {
              "label": "Tokyo Night (Nix)",
              "uiTheme": "vs-dark",
              "path": "./themes/tokyo-night-nix-color-theme.json"
            }
          ]
        }
      }
      MANIFEST
      cat > $out/share/vscode/extensions/nix.tokyo-night-nix/themes/tokyo-night-nix-color-theme.json << 'THEME'
      ${themeFile}
      THEME
    '';
    installPhase = "true";
  };
  # Nix-managed keys that always take priority over runtime changes
  # Written to a file in the Nix store to avoid shell quoting issues
  # (single quotes in font names break --argjson inline)
  nixManagedSettingsFile = pkgs.writeText "vscode-nix-managed.json" (builtins.toJSON {
    "workbench.colorTheme" = "Tokyo Night (Nix)";
    "editor.fontFamily" = "'FiraCode Nerd Font', 'monospace', monospace";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 14;
    "terminal.integrated.fontFamily" = "'FiraCode Nerd Font'";
  });

  nixRepoDir = "/persist/nixos";
  savedSettingsPath = "${nixRepoDir}/configs/vscode-settings.json";
  runtimeSettingsPath = "${config.home.homeDirectory}/.config/Code/User/settings.json";
  jq = "${pkgs.jq}/bin/jq";
in {
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = [tokyoNightThemeExtension];
    };
  };

  # On activation: merge saved runtime state + Nix-managed keys -> writable settings.json
  home.activation.vscodeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Start from saved runtime state, fall back to empty object
    if [ -f "${savedSettingsPath}" ]; then
      base=$(cat "${savedSettingsPath}")
    else
      base='{}'
    fi

    # Deep-merge Nix-managed keys on top (they always win)
    merged=$(echo "$base" | ${jq} --argjson nix "$(cat ${nixManagedSettingsFile})" '. * $nix')

    # Remove existing symlink if home-manager left one
    if [ -L "${runtimeSettingsPath}" ]; then
      rm -f "${runtimeSettingsPath}"
    fi

    mkdir -p "$(dirname "${runtimeSettingsPath}")"
    echo "$merged" | ${jq} '.' > "${runtimeSettingsPath}"
  '';

  # On shutdown: save runtime settings.json back to the Nix repo
  # Uses RemainAfterExit + ExecStop so ExecStop runs when the service is stopped at shutdown
  systemd.user.services.vscode-settings-save = {
    Unit = {
      Description = "Save VSCode settings back to Nix repo on shutdown";
      DefaultDependencies = false;
      Before = ["shutdown.target"];
    };
    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.coreutils}/bin/true";
      ExecStop = pkgs.writeShellScript "vscode-settings-save" ''
        if [ -f "${runtimeSettingsPath}" ] && [ ! -L "${runtimeSettingsPath}" ]; then
          ${jq} '.' "${runtimeSettingsPath}" > "${savedSettingsPath}.tmp" && \
            mv "${savedSettingsPath}.tmp" "${savedSettingsPath}"
        fi
      '';
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
