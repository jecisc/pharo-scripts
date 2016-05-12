StartupLoader default executeAtomicItems: {
	StartupAction name: 'Send annonymous usage data' code: '(Smalltalk at: #GTSpotterEventRecorderSettings) perform: #sendUsageData: with: (true)' runOnce: true.
	StartupAction name: 'Spotter Event Recorder URL address' code: '(Smalltalk at: #GTSpotterEventRecorderSettings) perform: #stringUrl: with: (''http://gc.dcc.uchile.cl.:8080/gt/events'')' runOnce: true.
	StartupAction name: 'The url for the script sharing service' code: '(Smalltalk at: #GTUrlProvider) perform: #stringUrlProvider: with: (''http://ws.stfx.eu/'')' runOnce: true.
	StartupAction name: 'Default' code: '(Smalltalk at: #StandardFonts) perform: #defaultFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 10 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Code' code: '(Smalltalk at: #StandardFonts) perform: #codeFont: with: ((LogicalFont familyName: ''Source Code Pro'' fallbackFamilyNames: nil pointSize: 10 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'List' code: '(Smalltalk at: #StandardFonts) perform: #listFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 10 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Menu' code: '(Smalltalk at: #StandardFonts) perform: #menuFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 10 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Button' code: '(Smalltalk at: #StandardFonts) perform: #buttonFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 10 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Window title' code: '(Smalltalk at: #StandardFonts) perform: #windowTitleFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 11 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Balloon-help' code: '(Smalltalk at: #StandardFonts) perform: #balloonFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 9 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Morphic halo' code: '(Smalltalk at: #StandardFonts) perform: #haloFont: with: ((LogicalFont familyName: ''Source Sans Pro'' fallbackFamilyNames: nil pointSize: 9 stretchValue: 5 weightValue: 400 slantValue: 0))' runOnce: true.
	StartupAction name: 'Growl position' code: '(Smalltalk at: #GrowlMorph) perform: #position: with: (#bottomLeft)' runOnce: true.
	StartupAction name: 'HandMorph event statistics' code: '(Smalltalk at: #HandMorph) perform: #logEventStatsEnabled: with: (false)' runOnce: true.
	StartupAction name: 'Run Long Tests' code: '(Smalltalk at: #LongTestCase) perform: #shouldRun: with: (true)' runOnce: true.
	StartupAction name: 'Default local repository directory' code: '(Smalltalk at: #MCDirectoryRepository) perform: #defaultDirectoryName: with: (''/Users/esteban/Dev/Pharo/xx'')' runOnce: true.
	StartupAction name: 'Local cache directory' code: '(Smalltalk at: #MCCacheRepository) perform: #cacheDirectory: with: ((FileReference basicNew instVarAt: 1 put: (FileSystem basicNew instVarAt: 1 put: ((AbsolutePath basicNew: 8)  basicAt: 1 put: ''C:''; basicAt: 2 put: ''Users''; basicAt: 3 put: ''JeCisC''; basicAt: 4 put: ''AppData''; basicAt: 5 put: ''Roaming''; basicAt: 6 put: ''Pharo''; basicAt: 7 put: ''images''; basicAt: 8 put: ''Common tools-Pharo 4.0 (stable)-01''; yourself); instVarAt: 2 put: (WindowsStore basicNew instVarAt: 1 put: 255; instVarAt: 2 put: nil; yourself); yourself); instVarAt: 2 put: ((AbsolutePath basicNew: 9)  basicAt: 1 put: ''C:''; basicAt: 2 put: ''Users''; basicAt: 3 put: ''JeCisC''; basicAt: 4 put: ''AppData''; basicAt: 5 put: ''Roaming''; basicAt: 6 put: ''Pharo''; basicAt: 7 put: ''images''; basicAt: 8 put: ''Common tools-Pharo 4.0 (stable)-01''; basicAt: 9 put: ''package-cache''; yourself); yourself))' runOnce: true.
	StartupAction name: #'Code Completion' code: '(Smalltalk at: #NECPreferences) perform: #enabled: with: (true)' runOnce: true.
	StartupAction name: 'Controller' code: '(Smalltalk at: #NECPreferences) perform: #useController: with: (NECController)' runOnce: true.
	StartupAction name: 'Background Color' code: '(Smalltalk at: #NECPreferences) perform: #backgroundColor: with: ((Color r: 0.25 g: 0.25 b: 0.25 alpha: 1.0))' runOnce: true.
	StartupAction name: 'Complete common prefixes using TAB in the suggested completions' code: '(Smalltalk at: #NECPreferences) perform: #expandPrefixes: with: (true)' runOnce: true.
	StartupAction name: 'Use ENTER to accept a suggested completion' code: '(Smalltalk at: #NECPreferences) perform: #useEnterToAccept: with: (true)' runOnce: true.
	StartupAction name: 'Use navigation keys for extended completion functionality' code: '(Smalltalk at: #NECPreferences) perform: #captureNavigationKeys: with: (false)' runOnce: true.
	StartupAction name: 'Case Sensitive' code: '(Smalltalk at: #NECPreferences) perform: #caseSensitive: with: (true)' runOnce: true.
	StartupAction name: 'Smart Characters' code: '(Smalltalk at: #NECPreferences) perform: #smartCharacters: with: (true)' runOnce: true.
	StartupAction name: 'Smart Characters with Single Space' code: '(Smalltalk at: #NECPreferences) perform: #smartCharactersWithSingleSpace: with: ('''')' runOnce: true.
	StartupAction name: 'Smart Characters with Double Space' code: '(Smalltalk at: #NECPreferences) perform: #smartCharactersWithDoubleSpace: with: (''[]{}'')' runOnce: true.
	StartupAction name: 'AST navigation' code: '(Smalltalk at: #NNavNavigation) perform: #useArrowsShortcuts: with: (false)' runOnce: true.
	StartupAction name: 'Open the browser on groups ?' code: '(Smalltalk at: #Nautilus) perform: #openOnGroups: with: (false)' runOnce: true.
	StartupAction name: 'Show hierarchy by default ?' code: '(Smalltalk at: #Nautilus) perform: #sortHierarchically: with: (true)' runOnce: true.
	StartupAction name: 'Set the max size of the navigation history' code: '(Smalltalk at: #Nautilus) perform: #historyMaxSize: with: (15)' runOnce: true.
	StartupAction name: 'Switch lists when opening on a class ?' code: '(Smalltalk at: #Nautilus) perform: #switchClassesAndPackages: with: (false)' runOnce: true.
	StartupAction name: 'Set the warning limit of source code pane' code: '(Smalltalk at: #Nautilus) perform: #warningLimit: with: (350)' runOnce: true.
	StartupAction name: 'Enable/disable warning for empty comments' code: '(Smalltalk at: #Nautilus) perform: #emptyCommentWarning: with: (true)' runOnce: true.
	StartupAction name: 'Use old style keys ?' code: '(Smalltalk at: #Nautilus) perform: #useOldStyleKeys: with: (false)' runOnce: true.
	StartupAction name: 'Show DEBUG menu?' code: '(Smalltalk at: #Nautilus) perform: #showDebugMenus: with: (false)' runOnce: true.
	StartupAction name: 'Use HTTP proxy' code: '(Smalltalk at: #NetworkSystemSettings) perform: #useHTTPProxy: with: (false)' runOnce: true.
	StartupAction name: 'Port' code: '(Smalltalk at: #NetworkSystemSettings) perform: #httpProxyPort: with: (80)' runOnce: true.
	StartupAction name: 'Server' code: '(Smalltalk at: #NetworkSystemSettings) perform: #httpProxyServer: with: ('''')' runOnce: true.
	StartupAction name: 'Exceptions' code: '(Smalltalk at: #NetworkSystemSettings) perform: #manageHttpProxyExceptions: with: ('''')' runOnce: true.
	StartupAction name: 'Proxy authentication' code: '(Smalltalk at: #NetworkSystemSettings) perform: #useNetworkAuthentification: with: (false)' runOnce: true.
	StartupAction name: 'User name' code: '(Smalltalk at: #NetworkSystemSettings) perform: #proxyUser: with: ('''')' runOnce: true.
	StartupAction name: 'Password' code: '(Smalltalk at: #NetworkSystemSettings) perform: #proxyPassword: with: ('''')' runOnce: true.
	StartupAction name: 'Blab email' code: '(Smalltalk at: #NetworkSystemSettings) perform: #blabEmail: with: ('''')' runOnce: true.
	StartupAction name: 'Use Polymorph difference tools' code: '(Smalltalk at: #PSMCPatchMorph) perform: #usedByDefault: with: (true)' runOnce: true.
	StartupAction name: 'Show groups on top ?' code: '(Smalltalk at: #PackageTreeNautilus) perform: #showGroupsOnTop: with: (true)' runOnce: true.
	StartupAction name: 'Systembrowser' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #browserTool: with: (PackageTreeNautilus)' runOnce: true.
	StartupAction name: 'Inspector' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #inspectorTool: with: (GTInspector)' runOnce: true.
	StartupAction name: 'Workspace' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #workspaceTool: with: (GTPlayground)' runOnce: true.
	StartupAction name: 'Debugger' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #debuggerTool: with: (SpecDebugger)' runOnce: true.
	StartupAction name: 'Messagelist' code: '((Smalltalk at: #Smalltalk) perform: #tools) perform: #messageListTool: with: (MessageBrowser)' runOnce: true.
}.

