StartupLoader default executeAtomicItems: {
	StartupAction name: 'Automatic submission' code: '(Smalltalk at: #SlReporter) perform: #autoSubmit: with: (false)' runOnce: true.
	StartupAction name: 'Show report summary' code: '(Smalltalk at: #SlReporter) perform: #showSummary: with: (true)' runOnce: true.
	StartupAction name: 'Show notifications' code: '(Smalltalk at: #SlReporter) perform: #showNotification: with: (true)' runOnce: true.
	StartupAction name: 'ShoreLine server address' code: '(Smalltalk at: #SlReporter) perform: #host: with: (''http://shoreline.inf.usi.ch'')' runOnce: true.
	StartupAction name: 'ShoreLine server port' code: '(Smalltalk at: #SlReporter) perform: #port: with: (80)' runOnce: true.
	StartupAction name: 'Class Template with Slots' code: '(Smalltalk at: #Slot) perform: #showSlotClassDefinition: with: (false)' runOnce: true.
	StartupAction name: 'Source Code Fonts' code: '(Smalltalk at: #SourceCodeFonts) perform: #useSourceCode: with: (SourceCodeFonts)' runOnce: true.
	StartupAction name: 'Allow the preferences to be loaded at startup' code: '(Smalltalk at: #StartupPreferencesLoader) perform: #allowStartupScript: with: (false)' runOnce: true.
	StartupAction name: 'Horizontal progress indicator position' code: '(Smalltalk at: #SystemProgressMorph) perform: #horizontalPosition: with: (0)' runOnce: true.
	StartupAction name: 'Vertical progress indicator position' code: '(Smalltalk at: #SystemProgressMorph) perform: #verticalPosition: with: (0)' runOnce: true.
	StartupAction name: 'Server mode' code: '(Smalltalk at: #WorldState) perform: #serverMode: with: (false)' runOnce: true.
	StartupAction name: 'Use locale' code: '(Smalltalk at: #Locale) perform: #activated: with: (false)' runOnce: true.
	StartupAction name: 'Keep task list open' code: '(Smalltalk at: #TaskListMorph) perform: #keepOpen: with: (false)' runOnce: true.
	StartupAction name: 'Taskbar' code: '(Smalltalk at: #TaskbarMorph) perform: #showTaskbar: with: (true)' runOnce: true.
	StartupAction name: 'Window preview' code: '(Smalltalk at: #TaskbarMorph) perform: #showWindowPreview: with: (true)' runOnce: true.
	StartupAction name: 'Maximum number of tasks to show' code: '(Smalltalk at: #TaskbarMorph) perform: #maximumButtons: with: (100)' runOnce: true.
	StartupAction name: 'Ignore line endings' code: '(Smalltalk at: #TextDiffBuilder) perform: #ignoreLineEndings: with: (true)' runOnce: true.
	StartupAction name: 'Pretty print differences' code: '(Smalltalk at: #TextDiffBuilder) perform: #diffsWithPrettyPrint: with: (false)' runOnce: true.
	StartupAction name: 'Icon Set' code: '(Smalltalk at: #ThemeIcons) perform: #uiIconClass: with: (IdeaUIThemeIcons)' runOnce: true.
}.

