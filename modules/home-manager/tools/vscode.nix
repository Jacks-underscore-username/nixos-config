{
  pkgs,
  lib,
  config,
  colors,
  ...
}: let
  c = colors;

  themeFile = builtins.toJSON {
    name = "Inkglow (Nix)";
    author = "Generated from lib/colors.nix";
    type = if c.themeIsDark then "dark" else "light";
    semanticClass = "inkglow-nix";
    semanticTokenColors = {
      "parameter.declaration" = {foreground = c.parameter;};
      parameter = {foreground = c.parameter;};
      "property.declaration" = {foreground = c.property;};
      "property.defaultLibrary" = {foreground = c.type;};
      "*.defaultLibrary" = {foreground = c.type;};
      "variable.defaultLibrary" = {foreground = c.type;};
      "variable.declaration" = {foreground = c.variable;};
      variable = {foreground = c.fg;};
    };
    colors = {
      # General
      "foreground" = c.fgSubtle;
      "descriptionForeground" = c.fgMuted;
      "disabledForeground" = c.fgMuted;
      "focusBorder" = "${c.fgMuted}33";
      "errorForeground" = c.fgMuted;
      "widget.shadow" = "#ffffff00";
      "scrollbar.shadow" = "#00000033";
      "badge.background" = "${c.accentAlt}30";
      "badge.foreground" = c.fg;
      "icon.foreground" = c.fgSubtle;
      "settings.headerForeground" = c.warning;
      "window.activeBorder" = c.bg;
      "window.inactiveBorder" = c.bg;
      "sash.hoverBorder" = c.accentAlt;

      # Toolbar
      "toolbar.activeBackground" = c.bgHighlight;
      "toolbar.hoverBackground" = c.bgHighlight;

      # Extension buttons
      "extensionButton.prominentBackground" = "${c.accentAlt}DD";
      "extensionButton.prominentHoverBackground" = "${c.accentAlt}AA";
      "extensionButton.prominentForeground" = "#ffffff";
      "extensionBadge.remoteBackground" = c.accentAlt;
      "extensionBadge.remoteForeground" = "#ffffff";

      # Buttons
      "button.background" = "${c.accentAlt}dd";
      "button.hoverBackground" = "${c.accentAlt}AA";
      "button.secondaryBackground" = c.bgHighlight;
      "button.foreground" = "#ffffff";
      "progressBar.background" = c.accentAlt;

      # Inputs
      "input.background" = c.bgElevated;
      "input.foreground" = c.fg;
      "input.border" = c.indentGuide;
      "input.placeholderForeground" = "${c.fgSubtle}8A";
      "inputOption.activeForeground" = c.fg;
      "inputOption.activeBackground" = "${c.accentAlt}44";

      "inputValidation.infoForeground" = c.fg;
      "inputValidation.infoBackground" = "${c.accentAlt}5c";
      "inputValidation.infoBorder" = c.accentAlt;
      "inputValidation.warningForeground" = "#000000";
      "inputValidation.warningBackground" = c.warning;
      "inputValidation.warningBorder" = c.number;
      "inputValidation.errorForeground" = c.fg;
      "inputValidation.errorBackground" = c.bgDeeper;
      "inputValidation.errorBorder" = c.errorBright;

      # Dropdowns
      "dropdown.foreground" = c.fgSubtle;
      "dropdown.background" = c.bgElevated;
      "dropdown.listBackground" = c.bgElevated;

      # Activity bar
      "activityBar.background" = c.bgPanel;
      "activityBar.foreground" = c.fgSubtle;
      "activityBar.inactiveForeground" = c.fgMuted;
      "activityBar.border" = c.bgPanel;
      "activityBarBadge.background" = c.accentAlt;
      "activityBarBadge.foreground" = "#ffffff";
      "activityBarTop.foreground" = c.fgSubtle;
      "activityBarTop.inactiveForeground" = c.fgMuted;

      # Sidebar
      "tree.indentGuidesStroke" = c.indentGuide;
      "sideBar.foreground" = c.fgSubtle;
      "sideBar.background" = c.bgPanel;
      "sideBar.border" = c.bgDeeper;
      "sideBarTitle.foreground" = c.fgSubtle;
      "sideBarSectionHeader.background" = c.bgPanel;
      "sideBarSectionHeader.foreground" = c.fg;
      "sideBarSectionHeader.border" = c.bgDeeper;
      "sideBar.dropBackground" = c.bgElevated;

      # Lists
      "list.dropBackground" = c.bgElevated;
      "list.deemphasizedForeground" = c.fgSubtle;
      "list.activeSelectionBackground" = c.bgHighlight;
      "list.activeSelectionForeground" = c.fg;
      "list.inactiveSelectionBackground" = c.bgElevated;
      "list.inactiveSelectionForeground" = c.fg;
      "list.focusBackground" = c.bgElevated;
      "list.focusForeground" = c.fg;
      "list.hoverBackground" = c.bgElevated;
      "list.hoverForeground" = c.fg;
      "list.highlightForeground" = c.accentAlt;
      "list.invalidItemForeground" = c.warning;
      "list.errorForeground" = c.error;
      "list.warningForeground" = c.bracket6;
      "listFilterWidget.background" = c.bgDeeper;
      "listFilterWidget.outline" = c.accentAlt;
      "listFilterWidget.noMatchesOutline" = c.errorBright;

      # Picker
      "pickerGroup.foreground" = c.fg;
      "pickerGroup.border" = c.bgDeeper;

      # Scrollbar
      "scrollbarSlider.background" = "${c.fgSubtle}15";
      "scrollbarSlider.hoverBackground" = "${c.fgSubtle}10";
      "scrollbarSlider.activeBackground" = "${c.fgSubtle}22";

      # Bracket highlighting
      "editorBracketHighlight.foreground1" = c.bracket1;
      "editorBracketHighlight.foreground2" = c.bracket2;
      "editorBracketHighlight.foreground3" = c.bracket3;
      "editorBracketHighlight.foreground4" = c.bracket4;
      "editorBracketHighlight.foreground5" = c.bracket5;
      "editorBracketHighlight.foreground6" = c.bracket6;
      "editorBracketHighlight.unexpectedBracket.foreground" = c.errorBright;

      "editorBracketPairGuide.activeBackground1" = c.bracket1;
      "editorBracketPairGuide.activeBackground2" = c.bracket2;
      "editorBracketPairGuide.activeBackground3" = c.bracket3;
      "editorBracketPairGuide.activeBackground4" = c.bracket4;
      "editorBracketPairGuide.activeBackground5" = c.bracket5;
      "editorBracketPairGuide.activeBackground6" = c.bracket6;

      # Editor
      "selection.background" = "${c.bgHighlight}40";
      "editor.background" = c.bg;
      "editor.foreground" = c.fg;
      "editor.foldBackground" = "${c.bgElevated}66";
      "editorLink.activeForeground" = c.fg;
      "editor.selectionBackground" = "${c.bgHighlight}4d";
      "editor.inactiveSelectionBackground" = "${c.bgHighlight}25";
      "editor.findMatchBackground" = "${c.accentAlt}66";
      "editor.findMatchBorder" = c.number;
      "editor.findMatchHighlightBackground" = "${c.accentAlt}66";
      "editor.findRangeHighlightBackground" = "${c.bgHighlight}33";
      "editor.rangeHighlightBackground" = "${c.bgHighlight}20";
      "editor.wordHighlightBackground" = "${c.bgHighlight}44";
      "editor.wordHighlightStrongBackground" = "${c.bgHighlight}55";
      "editor.selectionHighlightBackground" = "${c.bgHighlight}44";

      "editorCursor.foreground" = c.fg;
      "editorIndentGuide.background1" = c.indentGuide;
      "editorIndentGuide.activeBackground1" = c.indentGuideActive;
      "editorLineNumber.foreground" = c.indentGuideActive;
      "editorLineNumber.activeForeground" = c.fgSubtle;
      "editor.lineHighlightBackground" = c.bgElevated;
      "editorWhitespace.foreground" = c.indentGuideActive;

      "editorMarkerNavigation.background" = c.bgPanel;
      "editorHoverWidget.background" = c.bgPanel;
      "editorHoverWidget.border" = c.bgDeeper;

      "editorBracketMatch.background" = c.bgPanel;
      "editorBracketMatch.border" = c.bracketBad;

      # Overview ruler
      "editorOverviewRuler.border" = c.bgDeeper;
      "editorOverviewRuler.errorForeground" = c.errorBright;
      "editorOverviewRuler.warningForeground" = c.number;
      "editorOverviewRuler.infoForeground" = c.accent;
      "editorOverviewRuler.bracketMatchForeground" = c.bgDeeper;
      "editorOverviewRuler.findMatchForeground" = "${c.fg}44";
      "editorOverviewRuler.rangeHighlightForeground" = "${c.fg}44";
      "editorOverviewRuler.selectionHighlightForeground" = "${c.fg}22";
      "editorOverviewRuler.wordHighlightForeground" = "${c.constant}55";
      "editorOverviewRuler.wordHighlightStrongForeground" = "${c.constant}66";
      "editorOverviewRuler.modifiedForeground" = c.warning;
      "editorOverviewRuler.addedForeground" = c.success;
      "editorOverviewRuler.deletedForeground" = c.error;

      # Editor rulers / diagnostics
      "editorRuler.foreground" = c.bgDeeper;
      "editorError.foreground" = c.errorBright;
      "editorWarning.foreground" = c.number;
      "editorInfo.foreground" = c.accent;
      "editorHint.foreground" = c.accent;

      # Gutter
      "editorGutter.modifiedBackground" = c.warning;
      "editorGutter.addedBackground" = c.success;
      "editorGutter.deletedBackground" = c.error;
      "editorGhostText.foreground" = c.comment;

      # Minimap gutter
      "minimapGutter.modifiedBackground" = c.warning;
      "minimapGutter.addedBackground" = c.success;
      "minimapGutter.deletedBackground" = c.error;

      # Editor groups
      "editorGroup.border" = c.bgDeeper;
      "editorGroup.dropBackground" = c.bgElevated;
      "editorGroupHeader.tabsBorder" = c.bgDeeper;
      "editorGroupHeader.tabsBackground" = c.bgPanel;
      "editorGroupHeader.noTabsBackground" = c.bgPanel;
      "editorGroupHeader.border" = c.bgDeeper;
      "editorPane.background" = c.bg;

      # Editor widgets
      "editorWidget.foreground" = c.fgSubtle;
      "editorWidget.background" = c.bgPanel;
      "editorWidget.border" = c.bgDeeper;
      "editorWidget.resizeBorder" = "${c.fgMuted}33";

      "editorSuggestWidget.background" = c.bgPanel;
      "editorSuggestWidget.border" = c.bgDeeper;
      "editorSuggestWidget.selectedBackground" = c.bgHighlight;
      "editorSuggestWidget.highlightForeground" = c.warning;

      "editorCodeLens.foreground" = c.comment;
      "editorLightBulb.foreground" = c.number;
      "editorLightBulbAutoFix.foreground" = c.number;
      "editorInlayHint.foreground" = c.comment;

      # Peek view
      "peekView.border" = c.bgDeeper;
      "peekViewEditor.background" = c.bgPanel;
      "peekViewEditor.matchHighlightBackground" = "${c.accentAlt}66";
      "peekViewTitle.background" = c.bgDeeper;
      "peekViewTitleLabel.foreground" = c.fg;
      "peekViewTitleDescription.foreground" = c.fgSubtle;
      "peekViewResult.background" = c.bgDeeper;
      "peekViewResult.selectionForeground" = c.fg;
      "peekViewResult.selectionBackground" = "${c.accentAlt}33";
      "peekViewResult.lineForeground" = c.fg;
      "peekViewResult.fileForeground" = c.fgSubtle;
      "peekViewResult.matchHighlightBackground" = "${c.accentAlt}66";

      # Diff editor
      "diffEditor.insertedTextBackground" = "${c.success}20";
      "diffEditor.removedTextBackground" = "${c.errorBright}22";
      "diffEditor.insertedLineBackground" = "${c.success}20";
      "diffEditor.removedLineBackground" = "${c.errorBright}22";
      "diffEditorGutter.insertedLineBackground" = "${c.success}25";
      "diffEditorGutter.removedLineBackground" = "${c.errorBright}22";
      "diffEditorOverview.insertedForeground" = "${c.success}25";
      "diffEditorOverview.removedForeground" = "${c.errorBright}22";
      "diffEditor.diagonalFill" = c.bgHighlight;
      "diffEditor.unchangedCodeBackground" = "${c.bgElevated}66";

      "multiDiffEditor.headerBackground" = c.bg;
      "multiDiffEditor.border" = c.bg;

      # Breadcrumbs
      "breadcrumb.background" = c.bgPanel;
      "breadcrumbPicker.background" = c.bgPanel;
      "breadcrumb.foreground" = c.fgMuted;
      "breadcrumb.focusForeground" = c.fg;
      "breadcrumb.activeSelectionForeground" = c.fg;

      # Tabs
      "tab.activeBackground" = c.bgPanel;
      "tab.inactiveBackground" = c.bgPanel;
      "tab.activeForeground" = c.fg;
      "tab.hoverForeground" = c.fg;
      "tab.activeBorder" = c.accentAlt;
      "tab.inactiveForeground" = c.fgSubtle;
      "tab.border" = c.bgDeeper;
      "tab.unfocusedActiveForeground" = c.fg;
      "tab.unfocusedInactiveForeground" = c.fgSubtle;
      "tab.unfocusedHoverForeground" = c.fg;
      "tab.activeModifiedBorder" = c.bg;
      "tab.inactiveModifiedBorder" = c.bgHighlight;
      "tab.unfocusedActiveBorder" = c.bgHighlight;
      "tab.lastPinnedBorder" = c.bgHighlight;

      # Panel
      "panel.background" = c.bgPanel;
      "panel.border" = c.bgDeeper;
      "panelTitle.activeForeground" = c.fgSubtle;
      "panelTitle.inactiveForeground" = c.bracketBad;
      "panelTitle.activeBorder" = c.bgPanel;
      "panelInput.border" = c.bgPanel;

      # Status bar
      "statusBar.foreground" = c.fgSubtle;
      "statusBar.background" = c.bgPanel;
      "statusBar.border" = c.bgDeeper;
      "statusBar.noFolderBackground" = c.bgPanel;
      "statusBar.debuggingBackground" = c.bgPanel;
      "statusBar.debuggingForeground" = c.fgSubtle;
      "statusBarItem.activeBackground" = c.bgDeeper;
      "statusBarItem.hoverBackground" = c.bgHighlight;
      "statusBarItem.prominentBackground" = c.bgDeeper;
      "statusBarItem.prominentHoverBackground" = c.bgHighlight;

      # Title bar
      "titleBar.activeForeground" = c.fgSubtle;
      "titleBar.inactiveForeground" = c.fgSubtle;
      "titleBar.activeBackground" = c.bgPanel;
      "titleBar.inactiveBackground" = c.bgPanel;
      "titleBar.border" = c.bgDeeper;

      # Misc UI
      "walkThrough.embeddedEditorBackground" = c.bgPanel;
      "textLink.foreground" = c.accent;
      "textLink.activeForeground" = c.type;
      "textPreformat.foreground" = c.fgSubtle;
      "textBlockQuote.background" = c.bgPanel;
      "textCodeBlock.background" = c.bgPanel;
      "textSeparator.foreground" = c.indentGuideActive;

      # Debug
      "debugExceptionWidget.border" = c.errorBright;
      "debugExceptionWidget.background" = c.bgDeeper;
      "debugToolBar.background" = c.bgDeeper;
      "debugConsole.infoForeground" = c.fgSubtle;
      "debugConsole.errorForeground" = c.error;
      "debugConsole.sourceForeground" = c.fgSubtle;
      "debugConsole.warningForeground" = c.bracket6;
      "debugConsoleInputIcon.foreground" = c.func;
      "editor.stackFrameHighlightBackground" = "${c.number}20";
      "editor.focusedStackFrameHighlightBackground" = "${c.func}20";
      "debugView.stateLabelForeground" = c.fgSubtle;
      "debugView.stateLabelBackground" = c.bgElevated;
      "debugView.valueChangedHighlight" = "${c.accentAlt}aa";
      "debugTokenExpression.name" = c.type;
      "debugTokenExpression.value" = c.fg;
      "debugTokenExpression.string" = c.string;
      "debugTokenExpression.boolean" = c.keyword;
      "debugTokenExpression.number" = c.keyword;
      "debugTokenExpression.error" = c.error;
      "debugIcon.breakpointForeground" = c.errorBright;
      "debugIcon.breakpointDisabledForeground" = c.indentGuideActive;
      "debugIcon.breakpointUnverifiedForeground" = c.errorBright;

      # Terminal
      "terminal.background" = c.bgPanel;
      "terminal.foreground" = c.fgSubtle;
      "terminal.selectionBackground" = "${c.bgHighlight}4d";
      "terminal.ansiBlack" = c.ansiBlack;
      "terminal.ansiRed" = c.ansiRed;
      "terminal.ansiGreen" = c.ansiGreen;
      "terminal.ansiYellow" = c.ansiYellow;
      "terminal.ansiBlue" = c.ansiBlue;
      "terminal.ansiMagenta" = c.ansiMagenta;
      "terminal.ansiCyan" = c.ansiCyan;
      "terminal.ansiWhite" = c.ansiWhite;
      "terminal.ansiBrightBlack" = c.ansiBrightBlack;
      "terminal.ansiBrightRed" = c.ansiBrightRed;
      "terminal.ansiBrightGreen" = c.ansiBrightGreen;
      "terminal.ansiBrightYellow" = c.ansiBrightYellow;
      "terminal.ansiBrightBlue" = c.ansiBrightBlue;
      "terminal.ansiBrightMagenta" = c.ansiBrightMagenta;
      "terminal.ansiBrightCyan" = c.ansiBrightCyan;
      "terminal.ansiBrightWhite" = c.ansiBrightWhite;

      # Git decorations
      "gitDecoration.modifiedResourceForeground" = c.warning;
      "gitDecoration.ignoredResourceForeground" = c.fgMuted;
      "gitDecoration.deletedResourceForeground" = c.error;
      "gitDecoration.renamedResourceForeground" = c.success;
      "gitDecoration.addedResourceForeground" = c.success;
      "gitDecoration.untrackedResourceForeground" = c.success;
      "gitDecoration.conflictingResourceForeground" = "${c.number}cc";
      "gitDecoration.stageDeletedResourceForeground" = c.error;
      "gitDecoration.stageModifiedResourceForeground" = c.warning;

      # Notebook
      "notebook.editorBackground" = c.bg;
      "notebook.cellEditorBackground" = c.bgPanel;
      "notebook.cellBorderColor" = c.bgDeeper;
      "notebook.focusedCellBorder" = c.accentAlt;
      "notebook.cellStatusBarItemHoverBackground" = c.bgElevated;

      # Charts
      "charts.red" = c.error;
      "charts.blue" = c.accent;
      "charts.yellow" = c.number;
      "charts.orange" = c.keyword;
      "charts.green" = c.success;
      "charts.purple" = c.constant;
      "charts.foreground" = c.fg;
      "charts.lines" = c.bgPanel;

      # SCM graph
      "scmGraph.foreground1" = c.keyword;
      "scmGraph.foreground2" = c.number;
      "scmGraph.foreground3" = c.success;
      "scmGraph.foreground4" = c.accent;
      "scmGraph.foreground5" = c.constant;
      "scmGraph.historyItemHoverAdditionsForeground" = c.success;
      "scmGraph.historyItemHoverDeletionsForeground" = c.error;

      # Merge
      "merge.currentHeaderBackground" = "${c.success}25";
      "merge.currentContentBackground" = "${c.success}44";
      "merge.incomingHeaderBackground" = "${c.accentAlt}aa";
      "merge.incomingContentBackground" = "${c.accentAlt}44";

      # Notifications
      "notificationCenterHeader.background" = c.bgDeeper;
      "notifications.background" = c.bgDeeper;
      "notificationLink.foreground" = c.accent;
      "notificationsErrorIcon.foreground" = c.error;
      "notificationsWarningIcon.foreground" = c.warning;
      "notificationsInfoIcon.foreground" = c.accent;

      # Menus
      "menubar.selectionForeground" = c.fg;
      "menubar.selectionBackground" = c.bgElevated;
      "menubar.selectionBorder" = c.indentGuide;
      "menu.foreground" = c.fgSubtle;
      "menu.background" = c.bgPanel;
      "menu.selectionForeground" = c.fg;
      "menu.selectionBackground" = c.bgElevated;
      "menu.separatorBackground" = c.bgDeeper;
      "menu.border" = c.bgDeeper;

      # Chat / inline chat
      "chat.requestBorder" = c.indentGuide;
      "chat.avatarBackground" = c.accentAlt;
      "chat.avatarForeground" = c.fg;
      "chat.slashCommandBackground" = c.bgElevated;
      "chat.slashCommandForeground" = c.accent;
      "inlineChat.foreground" = c.fg;
      "inlineChatInput.background" = c.bgElevated;
      "inlineChatDiff.inserted" = "${c.success}40";
      "inlineChatDiff.removed" = "${c.errorBright}42";
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
        settings.foreground = c.comment;
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
        settings.foreground = c.comment;
      }
      {
        name = "Comment Doc Emphasized";
        scope = [
          "meta.other.type.phpdoc.php support.class"
          "comment.block.documentation storage.type"
          "comment.block.documentation punctuation.definition.block.tag"
          "comment.block.documentation entity.name.type.instance"
        ];
        settings.foreground = c.fgSubtle;
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
        settings.foreground = c.keyword;
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
          foreground = c.string;
        };
      }
      {
        name = "Colors";
        scope = [
          "constant.other.color"
          "constant.other.color.rgb-value.hex punctuation.definition.constant"
        ];
        settings.foreground = c.fg;
      }
      {
        name = "Invalid";
        scope = ["invalid" "invalid.illegal"];
        settings.foreground = c.errorBright;
      }
      {
        name = "Invalid deprecated";
        scope = "invalid.deprecated";
        settings.foreground = c.constant;
      }
      {
        name = "Storage Type";
        scope = "storage.type";
        settings.foreground = c.constant;
      }
      {
        name = "Storage - modifier, var, const, let";
        scope = [
          "meta.var.expr storage.type"
          "storage.modifier"
        ];
        settings.foreground = c.constant;
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
        settings.foreground = c.type;
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
        settings.foreground = c.type;
      }
      {
        name = "Spread";
        scope = [
          "keyword.operator.spread"
          "keyword.operator.rest"
        ];
        settings = {
          foreground = c.error;
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
        settings.foreground = c.special;
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
        settings.foreground = c.type;
      }
      {
        name = "Keyword";
        scope = [
          "keyword"
          "keyword.control"
          "keyword.other.important"
        ];
        settings.foreground = c.constant;
      }
      {
        name = "Keyword SQL";
        scope = "keyword.other.DML";
        settings.foreground = c.type;
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
        settings.foreground = c.constant;
      }
      {
        name = "Tag";
        scope = "entity.name.tag";
        settings.foreground = c.error;
      }
      {
        name = "Tag - Custom / Unrecognized";
        scope = [
          "entity.name.tag support.class.component"
          "meta.tag.custom entity.name.tag"
          "meta.tag.other.unrecognized.html.derivative entity.name.tag"
          "meta.tag"
        ];
        settings.foreground = c.tag;
      }
      {
        name = "Tag Punctuation";
        scope = ["punctuation.definition.tag"];
        settings.foreground = c.comment;
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
        settings.foreground = c.number;
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
        settings.foreground = c.type;
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
        settings.foreground = c.property;
      }
      {
        name = "Object Property";
        scope = [
          "variable.other.property"
          "support.variable.property"
          "support.variable.property.dom"
          "meta.function-call variable.other.object.property"
        ];
        settings.foreground = c.type;
      }
      {
        name = "Object Property (own)";
        scope = "variable.other.object.property";
        settings.foreground = c.fg;
      }
      {
        name = "Object Literal Member lvl 3 (Vue Prop Validation)";
        scope = "meta.objectliteral meta.object.member meta.objectliteral meta.object.member meta.objectliteral meta.object.member meta.object-literal.key";
        settings.foreground = c.success;
      }
      {
        name = "C-related Block Level Variables";
        scope = "source.cpp meta.block variable.other";
        settings.foreground = c.error;
      }
      {
        name = "Other Variable";
        scope = "support.other.variable";
        settings.foreground = c.error;
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
        settings.foreground = c.func;
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
        settings.foreground = c.func;
      }
      {
        name = "Function Argument";
        scope = [
          "variable.parameter.function.language.special"
          "variable.parameter"
          "meta.function.parameters punctuation.definition.variable"
          "meta.function.parameter variable"
        ];
        settings.foreground = c.parameter;
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
        settings.foreground = c.constant;
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
        settings.foreground = c.constant;
      }
      {
        name = "Inherited Class";
        scope = "entity.other.inherited-class";
        settings = {
          fontStyle = "";
          foreground = c.constant;
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
        settings.foreground = c.type;
      }
      {
        name = "Class Name";
        scope = "entity.name";
        settings.foreground = c.fg;
      }
      {
        name = "Support Function";
        scope = "support.function";
        settings.foreground = c.type;
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
        settings.foreground = c.accent;
      }
      {
        name = "CSS Font";
        scope = [
          "support.constant.font-name"
          "meta.definition.variable"
        ];
        settings.foreground = c.string;
      }
      {
        name = "CSS Class";
        scope = [
          "entity.other.attribute-name.class"
          "meta.at-rule.mixin.scss entity.name.function.scss"
        ];
        settings.foreground = c.string;
      }
      {
        name = "CSS ID";
        scope = "entity.other.attribute-name.id";
        settings.foreground = c.error;
      }
      {
        name = "CSS Tag";
        scope = "entity.name.tag.css";
        settings.foreground = c.type;
      }
      {
        name = "CSS Tag Reference, Pseudo & Class Punctuation";
        scope = [
          "entity.other.attribute-name.pseudo-class punctuation.definition.entity"
          "entity.other.attribute-name.pseudo-element punctuation.definition.entity"
          "entity.other.attribute-name.class punctuation.definition.entity"
          "entity.name.tag.reference"
        ];
        settings.foreground = c.number;
      }
      {
        name = "CSS Punctuation";
        scope = "meta.property-list";
        settings.foreground = c.fgSubtle;
      }
      {
        name = "CSS at-rule fix";
        scope = [
          "meta.property-list meta.at-rule.if"
          "meta.at-rule.return variable.parameter.url"
          "meta.property-list meta.at-rule.else"
        ];
        settings.foreground = c.keyword;
      }
      {
        name = "CSS Parent Selector Entity";
        scope = ["entity.other.attribute-name.parent-selector-suffix punctuation.definition.entity.css"];
        settings.foreground = c.property;
      }
      {
        name = "CSS Punctuation comma fix";
        scope = "meta.property-list meta.property-list";
        settings.foreground = c.fgSubtle;
      }
      {
        name = "SCSS @";
        scope = [
          "meta.at-rule.mixin keyword.control.at-rule.mixin"
          "meta.at-rule.include entity.name.function.scss"
          "meta.at-rule.include keyword.control.at-rule.include"
        ];
        settings.foreground = c.constant;
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
        settings.foreground = c.constant;
      }
      {
        name = "SCSS Include Mixin Argument";
        scope = "meta.property-list meta.at-rule.include";
        settings.foreground = c.fg;
      }
      {
        name = "CSS value";
        scope = "support.constant.property-value";
        settings.foreground = c.keyword;
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
        settings.foreground = c.error;
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
        settings.foreground = c.error;
      }
      {
        name = "HTML Attributes";
        scope = [
          "entity.other.attribute-name"
          "text.html.basic entity.other.attribute-name.html"
          "text.html.basic entity.other.attribute-name"
        ];
        settings.foreground = c.constant;
      }
      {
        name = "HTML Character Entity";
        scope = "text.html constant.character.entity";
        settings.foreground = c.type;
      }
      {
        name = "CSS psuedo selectors";
        scope = [
          "entity.other.attribute-name.pseudo-class"
          "entity.other.attribute-name.pseudo-element"
          "entity.other.attribute-name.placeholder"
          "meta.property-list meta.property-value"
        ];
        settings.foreground = c.constant;
      }
      {
        name = "Inserted";
        scope = "markup.inserted";
        settings.foreground = c.success;
      }
      {
        name = "Deleted";
        scope = "markup.deleted";
        settings.foreground = c.error;
      }
      {
        name = "Changed";
        scope = "markup.changed";
        settings.foreground = c.warning;
      }
      {
        name = "Regular Expressions";
        scope = "string.regexp";
        settings.foreground = c.string;
      }
      {
        name = "Regular Expressions - Punctuation";
        scope = "punctuation.definition.group";
        settings.foreground = c.error;
      }
      {
        name = "Regular Expressions - Character Class";
        scope = ["constant.other.character-class.regexp"];
        settings.foreground = c.constant;
      }
      {
        name = "Regular Expressions - Character Class Set";
        scope = [
          "constant.other.character-class.set.regexp"
          "punctuation.definition.character-class.regexp"
        ];
        settings.foreground = c.number;
      }
      {
        name = "Regular Expressions - Quantifier";
        scope = "keyword.operator.quantifier.regexp";
        settings.foreground = c.special;
      }
      {
        name = "Regular Expressions - Backslash";
        scope = "constant.character.escape.backslash";
        settings.foreground = c.fg;
      }
      {
        name = "Escape Characters";
        scope = "constant.character.escape";
        settings.foreground = c.special;
      }
      {
        name = "Decorators";
        scope = [
          "tag.decorator.js entity.name.tag.js"
          "tag.decorator.js punctuation.definition.tag.js"
        ];
        settings.foreground = c.func;
      }
      {
        name = "CSS Units";
        scope = "keyword.other.unit";
        settings.foreground = c.error;
      }
      {
        name = "JSON Key - Level 0";
        scope = ["source.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.accent;
      }
      {
        name = "JSON Key - Level 1";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.type;
      }
      {
        name = "JSON Key - Level 2";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.type;
      }
      {
        name = "JSON Key - Level 3";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.constant;
      }
      {
        name = "JSON Key - Level 4";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.number;
      }
      {
        name = "JSON Key - Level 5";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.type;
      }
      {
        name = "JSON Key - Level 6";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.property;
      }
      {
        name = "JSON Key - Level 7";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.error;
      }
      {
        name = "JSON Key - Level 8";
        scope = ["source.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json meta.structure.dictionary.value.json meta.structure.dictionary.json support.type.property-name.json"];
        settings.foreground = c.string;
      }
      {
        name = "Plain Punctuation";
        scope = "punctuation.definition.list_item.markdown";
        settings.foreground = c.fgSubtle;
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
        settings.foreground = c.fgSubtle;
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
        settings.foreground = c.fg;
      }
      {
        name = "Markdown - Markup Raw Inline";
        scope = "text.html.markdown markup.inline.raw.markdown";
        settings.foreground = c.constant;
      }
      {
        name = "Markdown - Markup Raw Inline Punctuation";
        scope = "text.html.markdown markup.inline.raw.markdown punctuation.definition.raw.markdown";
        settings.foreground = c.indentGuideActive;
      }
      {
        name = "Markdown - Heading 1";
        scope = [
          "heading.1.markdown entity.name"
          "heading.1.markdown punctuation.definition.heading.markdown"
        ];
        settings = {
          fontStyle = "bold";
          foreground = c.special;
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
          foreground = c.accentAlt;
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
          foreground = c.accent;
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
          foreground = c.type;
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
          foreground = c.fg;
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
          foreground = c.fgSubtle;
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
        settings.foreground = c.indentGuideActive;
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
        settings.foreground = c.property;
      }
      {
        name = "Markdown - Fenced Code Block";
        scope = [
          "markup.fenced_code.block.markdown"
          "markup.inline.raw.string.markdown"
          "variable.language.fenced.markdown"
        ];
        settings.foreground = c.special;
      }
      {
        name = "Markdown - Separator";
        scope = "meta.separator";
        settings = {
          fontStyle = "bold";
          foreground = c.comment;
        };
      }
      {
        name = "Markup - Table";
        scope = "markup.table";
        settings.foreground = c.variable;
      }
      {
        name = "Token - Info";
        scope = "token.info-token";
        settings.foreground = c.type;
      }
      {
        name = "Token - Warn";
        scope = "token.warn-token";
        settings.foreground = c.number;
      }
      {
        name = "Token - Error";
        scope = "token.error-token";
        settings.foreground = c.errorBright;
      }
      {
        name = "Token - Debug";
        scope = "token.debug-token";
        settings.foreground = c.constant;
      }
      {
        name = "Apache Tag";
        scope = "entity.tag.apacheconf";
        settings.foreground = c.error;
      }
      {
        name = "Preprocessor";
        scope = ["meta.preprocessor"];
        settings.foreground = c.property;
      }
      {
        name = "ENV value";
        scope = "source.env";
        settings.foreground = c.accent;
      }
    ];
  };

  inkglowThemeExtension = pkgs.stdenvNoCC.mkDerivation {
    pname = "inkglow-nix-theme";
    version = "1.0.0";
    dontUnpack = true;

    passthru = {
      vscodeExtPublisher = "nix";
      vscodeExtName = "inkglow-nix";
      vscodeExtUniqueId = "nix.inkglow-nix";
    };

    buildPhase = ''
      mkdir -p $out/share/vscode/extensions/nix.inkglow-nix/themes
      cat > $out/share/vscode/extensions/nix.inkglow-nix/package.json << 'MANIFEST'
      {
        "name": "inkglow-nix",
        "displayName": "Inkglow (Nix)",
        "version": "1.0.0",
        "publisher": "nix",
        "engines": { "vscode": "^1.50.0" },
        "categories": ["Themes"],
        "contributes": {
          "themes": [
            {
              "label": "Inkglow (Nix)",
              "uiTheme": "${if c.themeIsDark then "vs-dark" else "vs"}",
              "path": "./themes/inkglow-nix-color-theme.json"
            }
          ]
        }
      }
      MANIFEST
      cat > $out/share/vscode/extensions/nix.inkglow-nix/themes/inkglow-nix-color-theme.json << 'THEME'
      ${themeFile}
      THEME
    '';
    installPhase = "true";
  };

  nixManagedSettingsFile = pkgs.writeText "vscode-nix-managed.json" (builtins.toJSON {
    "workbench.colorTheme" = "Inkglow (Nix)";
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
      extensions = [inkglowThemeExtension];
    };
  };

  home.activation.vscodeSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f "${savedSettingsPath}" ]; then
      base=$(cat "${savedSettingsPath}")
    else
      base='{}'
    fi

    merged=$(echo "$base" | ${jq} --argjson nix "$(cat ${nixManagedSettingsFile})" '. * $nix')

    if [ -L "${runtimeSettingsPath}" ]; then
      rm -f "${runtimeSettingsPath}"
    fi

    mkdir -p "$(dirname "${runtimeSettingsPath}")"
    echo "$merged" | ${jq} '.' > "${runtimeSettingsPath}"
  '';

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
