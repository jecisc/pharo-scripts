StartupLoader default executeAtomicItems: {
	StartupAction name: 'Versionbrowser' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #versionBrowserTool: with: (NewVersionBrowser)' runOnce: true.
	StartupAction name: 'Filelist' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #fileListTool: with: (FileList)' runOnce: true.
	StartupAction name: 'Changesorter' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #changeSorterTool: with: (DualChangeSorterApplication)' runOnce: true.
	StartupAction name: 'Window position strategy' code: '(Smalltalk at: #RealEstateAgent) perform: #usedStrategy: with: (#cascadeFor:initialExtent:world:)' runOnce: true.
	StartupAction name: 'User interface theme' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #uiThemeClass: with: (Pharo3DarkTheme)' runOnce: true.
	StartupAction name: 'Window color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #windowColor: with: ((Color r: 0.25 g: 0.25 b: 0.25 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Rounded corners' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #preferRoundCorner: with: (false)' runOnce: true.
	StartupAction name: 'Fullscreen margin' code: '(Smalltalk at: #SystemWindow) perform: #fullscreenMargin: with: (25)' runOnce: true.
	StartupAction name: 'Fade background windows' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #fadedBackgroundWindows: with: (false)' runOnce: true.
	StartupAction name: 'Fast dragging' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #fastDragging: with: (false)' runOnce: true.
	StartupAction name: 'Text entry dialog width' code: '(Smalltalk at: #TextEntryDialogWindow) perform: #minimumWidth: with: (450)' runOnce: true.
	StartupAction name: 'Gradient filling' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #preferGradientFill: with: (false)' runOnce: true.
	StartupAction name: 'Flat appearance' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #flatMenu: with: (true)' runOnce: true.
	StartupAction name: 'Computed color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #autoMenuColor: with: (false)' runOnce: true.
	StartupAction name: 'Menu color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #menuColor: with: ((Color r: 0.25 g: 0.25 b: 0.25 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Menu selection color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #menuSelectionColor: with: ((Color r: 0.38 g: 0.638 b: 0.882 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Menu selection text color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #menuSelectionTextColor: with: ((Color r: 0.0 g: 0.0 b: 0.0 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Cycle both directions' code: '(Smalltalk at: #Morph) perform: #cycleHalosBothDirections: with: (false)' runOnce: true.
	StartupAction name: 'Encloses fullbounds' code: '(Smalltalk at: #HaloMorph) perform: #haloEnclosesFullBounds: with: (false)' runOnce: true.
	StartupAction name: 'Exhibits bounds' code: '(Smalltalk at: #HaloMorph) perform: #showBoundsInHalo: with: (false)' runOnce: true.
	StartupAction name: 'Animation' code: '((Smalltalk at: #UITheme) perform: #currentAnimationSettings) perform: #useAnimation: with: (false)' runOnce: true.
	StartupAction name: 'Animate closing' code: '((Smalltalk at: #UITheme) perform: #currentAnimationSettings) perform: #animateClosing: with: (false)' runOnce: true.
	StartupAction name: 'Delay' code: '((Smalltalk at: #UITheme) perform: #currentAnimationSettings) perform: #delay: with: (8)' runOnce: true.
	StartupAction name: 'Number of steps' code: '((Smalltalk at: #UITheme) perform: #currentAnimationSettings) perform: #numberOfSteps: with: (20)' runOnce: true.
	StartupAction name: 'Keyboard focus on mouse down' code: '(Smalltalk at: #MorphicModel) perform: #keyboardFocusOnMouseDown: with: (true)' runOnce: true.
	StartupAction name: 'Lose keyboard focus when mouse leave' code: '(Smalltalk at: #MorphicModel) perform: #mouseOverForKeyboardFocus: with: (false)' runOnce: true.
	StartupAction name: 'Show text editing state' code: '(Smalltalk at: #PluggableTextMorph) perform: #showTextEditingState: with: (true)' runOnce: true.
	StartupAction name: 'Balloon help' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #balloonHelpEnabled: with: (true)' runOnce: true.
	StartupAction name: 'String morphs are editable' code: '(Smalltalk at: #StringMorph) perform: #editableStringMorph: with: (false)' runOnce: true.
	StartupAction name: 'Show default action click menu' code: '(Smalltalk at: #Morph) perform: #defaultYellowButtonMenuEnabled: with: (false)' runOnce: true.
	StartupAction name: 'Easy selection' code: '(Smalltalk at: #WorldState) perform: #easySelectingWorld: with: (false)' runOnce: true.
	StartupAction name: 'Show logo' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #showDesktopLogo: with: (false)' runOnce: true.
	StartupAction name: 'Logo image file name' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopLogoFileName: with: ('''')' runOnce: true.
	StartupAction name: 'Color' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopColor: with: ((Color r: 0.295 g: 0.295 b: 0.295 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Gradient' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #useDesktopGradientFill: with: (false)' runOnce: true.
	StartupAction name: 'Other color' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopGradientFillColor: with: ((Color r: 0.937 g: 0.937 b: 0.937 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Direction' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopGradientDirection: with: (#Vertical)' runOnce: true.
	StartupAction name: 'Origin' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopGradientOrigin: with: (#topLeft)' runOnce: true.
	StartupAction name: 'Desktop background image file name' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #desktopImageFileName: with: (''C:\Users\JeCisC\Google Drive\Personnel\fanart\Tower.Of.God.full.1126589-1-.jpg'')' runOnce: true.
	StartupAction name: 'Sound' code: '(Smalltalk at: #SoundSystem) perform: #soundEnabled: with: (false)' runOnce: true.
	StartupAction name: 'Use theme sounds' code: '(Smalltalk at: #SoundTheme) perform: #useThemeSounds: with: (true)' runOnce: true.
	StartupAction name: 'Sound theme' code: '(Smalltalk at: #PolymorphSystemSettings) perform: #soundThemeClass: with: (SoundTheme)' runOnce: true.
	StartupAction name: 'Cascaded message inside parentheses' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #cascadedMessageInsideParentheses: with: (false)' runOnce: true.
	StartupAction name: 'Format comment with statements' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #formatCommentWithStatements: with: (true)' runOnce: true.
	StartupAction name: 'Indent string' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #indentString: with: (''	'')' runOnce: true.
	StartupAction name: 'Indents for keywords' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #indentsForKeywords: with: (1)' runOnce: true.
	StartupAction name: 'Keep block in message' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #keepBlockInMessage: with: (true)' runOnce: true.
	StartupAction name: 'Line up block brackets' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #lineUpBlockBrackets: with: (false)' runOnce: true.
	StartupAction name: 'Method signature on multiple lines' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #methodSignatureOnMultipleLines: with: (false)' runOnce: true.
	StartupAction name: 'Max line length' code: '(Smalltalk at: #RBConfigurableFormatter) perform: #maxLineLength: with: (120)' runOnce: true.
}.

