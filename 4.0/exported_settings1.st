StartupLoader default executeAtomicItems: {
	StartupAction name: 'Default Compiler' code: '(Smalltalk at: #SmalltalkImage) perform: #compilerClass: with: (OpalCompiler)' runOnce: true.
	StartupAction name: 'Bytecode Backend' code: '(Smalltalk at: #CompilationContext) perform: #bytecodeBackend: with: (EncoderForV3PlusClosures)' runOnce: true.
	StartupAction name: 'Author identification' code: '(Smalltalk at: #Author) perform: #fullName: with: (''CyrilFerlicot'')' runOnce: true.
	StartupAction name: 'Make a snapshot of new version before quit' code: '(Smalltalk at: #CommandLineUIManager) perform: #snapshotErrorImage: with: (false)' runOnce: true.
	StartupAction name: 'Raise a blocking dialog' code: '(Smalltalk at: #Deprecation) perform: #raiseWarning: with: (false)' runOnce: true.
	StartupAction name: 'Transcript message' code: '(Smalltalk at: #Deprecation) perform: #showWarning: with: (false)' runOnce: true.
	StartupAction name: 'Enable cmd-dot interrupt key' code: '(Smalltalk at: #UserInterruptHandler) perform: #cmdDotEnabled: with: (true)' runOnce: true.
	StartupAction name: 'Process browser monitors CPU usage' code: '(Smalltalk at: #CPUWatcher) perform: #cpuWatcherEnabled: with: (true)' runOnce: true.
	StartupAction name: 'Flash damaged morphic region' code: '(Smalltalk at: #WorldState) perform: #debugShowDamage: with: (false)' runOnce: true.
	StartupAction name: 'Write message to debug log file when fall into debugger' code: '(Smalltalk at: #SpecDebugger) perform: #logDebuggerStackToFile: with: (true)' runOnce: true.
	StartupAction name: 'Directly open the full Debugger' code: '(Smalltalk at: #SpecDebugger) perform: #alwaysOpenFullDebugger: with: (true)' runOnce: true.
	StartupAction name: 'Filter out common message sends' code: '(Smalltalk at: #SpecDebugger) perform: #filterCommonMessageSends: with: (false)' runOnce: true.
	StartupAction name: 'Filter out doIt sends' code: '(Smalltalk at: #SpecDebuggerStack) perform: #filterDoItSelectors: with: (false)' runOnce: true.
	StartupAction name: 'Filter out nil message sends' code: '(Smalltalk at: #SpecDebuggerStack) perform: #filterNilSelectors: with: (false)' runOnce: true.
	StartupAction name: 'Filter out kernel classes message sends' code: '(Smalltalk at: #SpecDebuggerStack) perform: #filterKernelClasses: with: (false)' runOnce: true.
	StartupAction name: 'Log file name' code: '(Smalltalk at: #Smalltalk) perform: #logFileName: with: (''/tmp/pillar.log'')' runOnce: true.
	StartupAction name: 'Delay Scheduler' code: '(Smalltalk at: #Delay) perform: #delaySchedulerClass: with: (DelayMicrosecondScheduler)' runOnce: true.
	StartupAction name: 'Size of the Unselected Items History' code: '(Smalltalk at: #DialogItemsChooserUI) perform: #alreadySearchedUnselectedItemsListMaxSize: with: (15)' runOnce: true.
	StartupAction name: 'Size of the Selected Items History' code: '(Smalltalk at: #DialogItemsChooserUI) perform: #alreadySearchedSelectedItemsListMaxSize: with: (15)' runOnce: true.
	StartupAction name: 'Selection color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #selectionColor: with: ((Color r: 0.686 g: 0.835 b: 0.979 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Unfocused selection color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #unfocusedSelectionColor: with: ((Color r: 0.729 g: 0.8320000000000001 b: 0.934 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Selection text color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #selectionTextColor: with: ((Color r: 0.0 g: 0.0 b: 0.0 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Show the colored bar on the current line' code: '(Smalltalk at: #TextEditor) perform: #useSelectionBar: with: (true)' runOnce: true.
	StartupAction name: 'Selection bar color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #selectionBarColor: with: ((Color r: 0.686 g: 0.835 b: 0.979 alpha: 0.059000000000000004))' runOnce: true.
	StartupAction name: 'Use the secondary selection' code: '(Smalltalk at: #TextEditor) perform: #useSecondarySelection: with: (true)' runOnce: true.
	StartupAction name: 'Secondary selection color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #secondarySelectionColor: with: ((Color r: 0.927 g: 0.962 b: 0.995 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Secondary selection text color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #secondarySelectionTextColor: with: ((Color r: 0.0 g: 0.0 b: 0.0 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Use the find and replace selection' code: '(Smalltalk at: #TextEditor) perform: #useFindReplaceSelection: with: (true)' runOnce: true.
	StartupAction name: 'Find replace selection color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #findReplaceSelectionColor: with: ((Color r: 1.0 g: 0.6 b: 0.0 alpha: 0.4))' runOnce: true.
	StartupAction name: 'Find replace selection text color' code: '((Smalltalk at: #UITheme) perform: #currentSettings) perform: #findReplaceSelectionTextColor: with: ((Color r: 0.0 g: 0.0 b: 0.0 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Case sensitive search' code: '(Smalltalk at: #TextEditor) perform: #caseSensitiveFinds: with: (false)' runOnce: true.
	StartupAction name: 'Blinking text cursor' code: '(Smalltalk at: #Editor) perform: #blinkingCursor: with: (true)' runOnce: true.
	StartupAction name: 'Dumbbell-shaped text cursor' code: '(Smalltalk at: #Editor) perform: #dumbbellCursor: with: (false)' runOnce: true.
	StartupAction name: 'Skip over white space' code: '(Smalltalk at: #Editor) perform: #skipOverMultipleSpaces: with: (false)' runOnce: true.
	StartupAction name: 'Walk along displayed line' code: '(Smalltalk at: #TextEditor) perform: #walkAlongDisplayedLine: with: (true)' runOnce: true.
	StartupAction name: 'Free type' code: '(Smalltalk at: #FreeTypeSystemSettings) perform: #noFt2Library: with: (''Free type fonts are not available'')' runOnce: true.
	StartupAction name: 'Use Free type' code: '(Smalltalk at: #FreeTypeSystemSettings) perform: #loadFt2Library: with: (true)' runOnce: true.
	StartupAction name: 'Update fonts at startup' code: '(Smalltalk at: #FreeTypeSettings) perform: #updateFontsAtImageStartup: with: (false)' runOnce: true.
	StartupAction name: 'Glyph contrast' code: '((Smalltalk at: #FreeTypeSettings) perform: #current) perform: #glyphContrast: with: (55.0)' runOnce: true.
	StartupAction name: 'Number of inspector panes' code: '(Smalltalk at: #GTInspector) perform: #numberOfInspectorPanes: with: (2)' runOnce: true.
	StartupAction name: 'GTInspector' code: '(Smalltalk at: #GTInspector) perform: #setGTInspectorEnabledStatus: with: (true)' runOnce: true.
	StartupAction name: 'Inspector width' code: '(Smalltalk at: #GTInspector) perform: #preferredWidth: with: (744.0)' runOnce: true.
	StartupAction name: 'Inspector height' code: '(Smalltalk at: #GTInspector) perform: #preferredHeight: with: (400.0)' runOnce: true.
	StartupAction name: 'Remember extent of Inspector' code: '(Smalltalk at: #GTInspector) perform: #rememberPreferredExtent: with: (true)' runOnce: true.
	StartupAction name: 'GTPlayground' code: '(Smalltalk at: #GTPlayground) perform: #setGTPlaygroundEnabledStatus: with: (true)' runOnce: true.
	StartupAction name: 'Local Playground cache directory' code: '(Smalltalk at: #GTPlayBook) perform: #cacheDirectory: with: ((FileReference basicNew instVarAt: 1 put: (FileSystem basicNew instVarAt: 1 put: ((AbsolutePath basicNew: 8)  basicAt: 1 put: ''C:''; basicAt: 2 put: ''Users''; basicAt: 3 put: ''JeCisC''; basicAt: 4 put: ''AppData''; basicAt: 5 put: ''Roaming''; basicAt: 6 put: ''Pharo''; basicAt: 7 put: ''images''; basicAt: 8 put: ''Common tools-Pharo 4.0 (stable)-01''; yourself); instVarAt: 2 put: (WindowsStore basicNew instVarAt: 1 put: 255; instVarAt: 2 put: nil; yourself); yourself); instVarAt: 2 put: ((RelativePath basicNew: 1)  basicAt: 1 put: ''play-cache''; yourself); yourself))' runOnce: true.
	StartupAction name: 'Local Playground stash directory' code: '(Smalltalk at: #GTPlayBook) perform: #stashDirectory: with: ((FileReference basicNew instVarAt: 1 put: (FileSystem basicNew instVarAt: 1 put: ((AbsolutePath basicNew: 8)  basicAt: 1 put: ''C:''; basicAt: 2 put: ''Users''; basicAt: 3 put: ''JeCisC''; basicAt: 4 put: ''AppData''; basicAt: 5 put: ''Roaming''; basicAt: 6 put: ''Pharo''; basicAt: 7 put: ''images''; basicAt: 8 put: ''Common tools-Pharo 4.0 (stable)-01''; yourself); instVarAt: 2 put: (WindowsStore basicNew instVarAt: 1 put: 255; instVarAt: 2 put: nil; yourself); yourself); instVarAt: 2 put: ((RelativePath basicNew: 1)  basicAt: 1 put: ''play-stash''; yourself); yourself))' runOnce: true.
	StartupAction name: 'Playground width' code: '(Smalltalk at: #GTPlayground) perform: #preferredWidth: with: (600.0)' runOnce: true.
	StartupAction name: 'Playground height' code: '(Smalltalk at: #GTPlayground) perform: #preferredHeight: with: (400.0)' runOnce: true.
	StartupAction name: 'Remember extent of Playground' code: '(Smalltalk at: #GTPlayground) perform: #rememberPreferredExtent: with: (true)' runOnce: true.
}.

