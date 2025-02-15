"
A class to generate my toolbar menu and add some utilities.
"
Class {
	#name : 'PharoQuickAccess',
	#superclass : 'PharoAbstractSettings',
	#instVars : [
		'counter',
		'isTodoEnabled'
	],
	#classVars : [
		'UniqueInstance'
	],
	#classInstVars : [
		'directoriesMap'
	],
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'world menu' }
PharoQuickAccess class >> buildAddToIcebergOn: aBuilder [
	self createAddToIcebergSubmenusFrom: self sharedRepositoryFolder on: aBuilder
]

{ #category : 'world menu' }
PharoQuickAccess class >> buildOpenNativelyOn: aBuilder [

	(aBuilder item: #'Pharo scripts root')
		action: [ self rootFolder openInOSFileBrowser ];
		order: 1;
		help: 'Open root in finder';
		iconName: #smallDoIt.
	self createOpenNativelySubmenusFrom: self sharedRepositoryFolder on: aBuilder
]

{ #category : 'world menu' }
PharoQuickAccess class >> buildScriptsOf: aClass on: aBuilder [

	(aBuilder item: ('From: ' , aClass name) asSymbol)
		iconName: #configNew;
		with: [
			(Pragma allNamed: #script in: aClass class) do: [ :pragma |
					(aBuilder item: (' ' join: pragma method selector capitalized mySplitCamelCase))
						action: [ aClass perform: pragma method selector ];
						help: 'Launch script.';
						iconName: #smallDoIt ] ].

	aClass subclassesDo: [ :subClass | self buildScriptsOf: subClass on: aBuilder ]
]

{ #category : 'world menu' }
PharoQuickAccess class >> buildSelectBackgroundOn: aBuilder [

	((self backgroundFolder allFiles reject: [ :f | f basename beginsWith: '.' ]) sorted: #basename ascending) do: [ :background |
		(aBuilder item: background basename asSymbol)
			action: [ PolymorphSystemSettings desktopImageFileName: background fullName ];
			help: 'background';
			iconName: #smallDoIt ]
]

{ #category : 'world menu' }
PharoQuickAccess class >> buildSubmenu: cat on: aBuilder [
	"Sometimes I add insecable spaces to separate different menus with the same name."

	(self methodsIn: (cat asLowercase copyWithout: $ )) do: [ :method |
		(method pragmaAt: #name:) ifNotNil: [ :p |
			(aBuilder item: (p argumentAt: 1))
				parent: cat;
				action: [ self execute: method selector ];
				help: 'Todo';
				iconName: #smallDoIt ] ]
]

{ #category : 'world menu' }
PharoQuickAccess class >> createAddToIcebergSubmenusFrom: aFolder on: aBuilder [
	self
		recursivelyCreateCommandForRepositoriesFrom: aFolder
		action: [ :dir |
			(IceRepositoryCreator new
				location: dir;
				createRepository) register.
				self focusIceberg ]
		prefix: ' '
		on: aBuilder
]

{ #category : 'world menu' }
PharoQuickAccess class >> createOpenNativelySubmenusFrom: aFolder on: aBuilder [
	self recursivelyCreateCommandForRepositoriesFrom: aFolder action: [ :dir | dir openInOSFileBrowser ] prefix: '  ' on: aBuilder
]

{ #category : 'accessing' }
PharoQuickAccess class >> execute: aSelector [
	[ self instance perform: aSelector.
	self inform: 'Executed with success: ' , aSelector ]
		on: Error
		do: [ :ex |
			self
				inform:
					'Error during execution.
' , ex asString ]
]

{ #category : 'accessing' }
PharoQuickAccess class >> executeBlock: aBlock [
	[ aBlock value.
	self inform: 'Executed with success' ]
		on: Error
		do: [ :ex |
			self
				inform:
					'Error during execution.
' , ex asString ]
]

{ #category : 'actions' }
PharoQuickAccess class >> focusIceberg [
	"This method will look for an open tip repository browser open (This is the entry point of Iceberg). If one is open, bring it to front. Else, open one."

	(self currentWorld windowsSatisfying: [ :window | window label = 'Repositories' ])
		ifEmpty: [ [ IceTipRepositoriesBrowser new openWithSpec ]
				on: Error
				do: [ self inform: 'Opening Iceberg only works in Pharo >= 7' ] ]
		ifNotEmpty: [ :repos |
			| window |
			window := repos first.
			window isMinimized ifTrue: [ window restore ] ifFalse: [ window activate ] ]
]

{ #category : 'class initialization' }
PharoQuickAccess class >> initialize [
	self install.
	Smalltalk at: #OwO put: self instance
]

{ #category : 'actions' }
PharoQuickAccess class >> install [
	"Unsubscribe to subscribe only once"
	SystemAnnouncer uniqueInstance unsubscribe: self.
	SystemAnnouncer uniqueInstance weak
		when: MethodAnnouncement
		send: #methodAnnouncementReceived: to: self
]

{ #category : 'accessing' }
PharoQuickAccess class >> instance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : 'instance creation' }
PharoQuickAccess class >> methodAnnouncementReceived: anAnnouncement [
	"No need to rebuild if it contains the world menu pragma"

	self flag: #pharo6.	"Menubar was introduced in Pharo 7"
	SystemVersion current major < 7 ifTrue: [ ^ self ].

	anAnnouncement methodAffected pragmas
		detect: [ :e | e selector = 'worldMenu' ]
		ifFound: [ :p | ^ self ].

	({self . self class} anySatisfy: [ :class | anAnnouncement methodAffected methodClass = class ]) ifTrue: [ self resetMenubar ]
]

{ #category : 'accessing' }
PharoQuickAccess class >> methodsIn: aProtocol [

	^ (self methods select: [ :method |
		   (method protocol isString
			    ifTrue: [ method protocol ]
			    ifFalse: [ method protocol name ]) = aProtocol ]) sort: #selector ascending
]

{ #category : 'world menu' }
PharoQuickAccess class >> recursivelyCreateCommandForRepositoriesFrom: aFolder action: action prefix: aString on: aBuilder [

	((self subDirectoriesOf: aFolder) sort: [ :a | a basename asLowercase ] ascending) do: [ :dir |
		((self subDirectoriesOf: dir) anySatisfy: [ :e | e basename = '.git' ])
			ifTrue: [
				(aBuilder item: (aString , dir basename) asSymbol)
					action: [ self executeBlock: [ action cull: dir ] ];
					help: 'TODO';
					iconName: #smallDoIt ]
			ifFalse: [
				(aBuilder item: (aString , dir basename) asSymbol)
					iconName: #configNew;
					with: [
						self
							recursivelyCreateCommandForRepositoriesFrom: dir
							action: action
							prefix: aString
							on: aBuilder ] ] ]
]

{ #category : 'instance creation' }
PharoQuickAccess class >> resetMenubar [
	"Invalidate cache to speedup menu creation"
	directoriesMap := nil.
	MenubarMorph reset
]

{ #category : 'accessing' }
PharoQuickAccess class >> subDirectoriesOf: aDirectory [
	directoriesMap ifNil: [ directoriesMap := Dictionary new ].
	^ directoriesMap at: aDirectory ifAbsentPut: [ aDirectory directories ]
]

{ #category : 'world menu' }
PharoQuickAccess class >> worldMenuSectionsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Scripts)
		order: 6.0;
		iconName: #changeUpdate;
		with: [ (aBuilder item: #Conveniance)
				order: 1;
				iconName: #configNew;
				with: [ self buildSubmenu: #Conveniance on: aBuilder.
					(aBuilder item: #'Select background')
						order: 1;
						iconName: #configNew;
						with: [ self buildSelectBackgroundOn: aBuilder ] ].

			(aBuilder item: #Loading)
				order: 5;
				iconName: #configNew;
				with: [ self buildSubmenu: #Loading on: aBuilder ].

			(aBuilder item: #'My scripts')
				order: 15;
				iconName: #configNew;
				with: [ self buildScriptsOf: Scripts on: aBuilder ].

			(aBuilder item: #'Browse ')
				order: 20;
				iconName: #configNew;
				with: [ self buildSubmenu: #'Browse ' on: aBuilder ].

			(aBuilder item: #RecentWindows)
				order: 23;
				iconName: #configNew;
				with: [ self buildSubmenu: #RecentWindows on: aBuilder ].

			(aBuilder item: #'Add to Iceberg')
				order: 25;
				iconName: #configNew;
				with: [ self buildAddToIcebergOn: aBuilder ].

			(aBuilder item: #'Open natively Iceberg repository')
				order: 30;
				iconName: #configNew;
				with: [ self buildOpenNativelyOn: aBuilder ] ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings [
	<name: #'Pharo common settings'>
	PharoCommonSettings class browse
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings10 [
	<name: #'Pharo common settings 10'>
	self class environment at: #Pharo10CommonSettings ifPresent: [ :class | class class browse ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings11 [
	<name: #'Pharo common settings 11'>
	self class environment at: #Pharo11CommonSettings ifPresent: [ :class | class class browse ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings5 [
	<name: #'Pharo common settings 5'>
	self class environment at: #Pharo5CommonSettings ifPresent: [ :class | class class browse ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings8 [
	<name: #'Pharo common settings 8'>
	self class environment at: #Pharo8CommonSettings ifPresent: [ :class | class class browse ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseCommonSettings9 [
	<name: #'Pharo common settings 9'>
	self class environment at: #Pharo9CommonSettings ifPresent: [ :class | class class browse ]
]

{ #category : 'conveniance' }
PharoQuickAccess >> browseIcons [
	<name: #'Browse icons'>
	Smalltalk ui icons inspect
]

{ #category : 'browse' }
PharoQuickAccess >> browseQuickAccess [
	<name: #QuickAccess>
	self class browse
]

{ #category : 'browse' }
PharoQuickAccess >> browseScripts [
	<name: #'Browse scripts'>
	self class environment at: #Scripts ifPresent: [ :class | class class browse ]
]

{ #category : 'browse' }
PharoQuickAccess >> browseSpecDemo [

	<name: #'Spec demo'>
	(self class environment at: #SpecDemo ifAbsent: [ self class environment at: #SpDemo ]) browse
]

{ #category : 'counter' }
PharoQuickAccess >> counter [
	^ counter
]

{ #category : 'counter' }
PharoQuickAccess >> decrement [
	counter := counter - 1
]

{ #category : 'conveniance' }
PharoQuickAccess >> findIcebergRepos [
	<name: #'Find Iceberg repositories'>

	Smalltalk at: #PharoCommonSettings ifPresent: [ :c | c initializePotentialIcebergRepos ]
]

{ #category : 'recentwindows' }
PharoQuickAccess >> flushRecentWindow [
	<name: #'Flush recent windows'>
	RecentlyClosedWindowsSaver default flush
]

{ #category : 'conveniance' }
PharoQuickAccess >> gc [
	<name: #'Garbage collect'>
	5 timesRepeat: [ Smalltalk garbageCollect ]
]

{ #category : 'recentwindows' }
PharoQuickAccess >> groupWindowForGitReposWithPatter [
	<name: 'Open group window with git repos using pattern'>
	| repos group |
	(UIManager default textEntry: 'Substring for the repos?')
		ifNotNil: [ :pattern |
			repos := IceRepository registry select: [ :e | e name includesSubstring: pattern ].

			group := GroupWindowMorph new.

			repos do: [ :r | group addWindow: (IceTipWorkingCopyBrowser on: (IceTipRepositoryModel on: r) beCached) openWithSpec window ].
			group tabGroup selectedPageIndex: 1.
			(group openInWindowLabeled: 'Common repos') expandBoxHit ]
]

{ #category : 'conveniance' }
PharoQuickAccess >> importReader [

	<name: #'Import reader'>
	"38000 LoC"
	[ FamixPythonImporter import: '/Users/cyril/testPython/reader' asFileReference ] spy
]

{ #category : 'counter' }
PharoQuickAccess >> increment [
	counter := counter + 1
]

{ #category : 'initialization' }
PharoQuickAccess >> initialize [
	super initialize.
	self resetCounter.
	isTodoEnabled := false
]

{ #category : 'loading' }
PharoQuickAccess >> installDiscordSt [
	<name: #'Install DiscordSt'>
	Metacello new
		baseline: #DiscordSt;
		repository: 'github://JurajKubelka/DiscordSt/src';
		load: #('light')
]

{ #category : 'loading' }
PharoQuickAccess >> installGeometry [
	<name: #'Install Geometry'>

	Metacello new
		baseline: #Geometry;
		githubUser: 'TelescopeSt' project: 'Geometry' commitish: 'master' path: 'src';
		load
]

{ #category : 'loading' }
PharoQuickAccess >> installWebPokedex [
	<name: #'Install WebPokedex'>
	Metacello new
		baseline: #WebPokedex;
		githubUser: 'jecisc'
			project: 'WebPokedex'
			commitish: 'development'
			path: 'src';
		onWarningLog;
		load.

	(Smalltalk at: #WPServer) readStonModelWithContextFile: '../../GitRepositories/WebPokedex/Ressources/devContext.ston'
]

{ #category : 'initialization' }
PharoQuickAccess >> isTodoEnabled [

	^ isTodoEnabled
]

{ #category : 'conveniance' }
PharoQuickAccess >> logAllUnusedVariables [
	<name: #'Log all unused variables'>
	Transcript clear; open.
	Object
		allSubclassesDo: [ :class |
			class instVarNames
				do: [ :each | (class whichSelectorsAccess: each) size = 0 ifTrue: [ Transcript crShow: 'Class: ' , class printString , ' var: ' , each ] ] ]
]

{ #category : 'recentwindows' }
PharoQuickAccess >> openCommonTools [
	<name: #'Open common tools'>
	| group |
	group := GroupWindowMorph new
		addWindow: MCWorkingCopyBrowser new show;
		addWindow: GTPlayground open;
		addWindow: Transcript open;
		addWindow: TestRunner open.
	group tabGroup selectedPageIndex: 1.
	(group openInWindowLabeled: 'Common Tools') expandBoxHit
]

{ #category : 'conveniance' }
PharoQuickAccess >> openImageNatively [
	<name: #'Open image natively'>
	FileLocator image openInOSFileBrowser
]

{ #category : 'recentwindows' }
PharoQuickAccess >> openRecentWindow [
	<name: #'Open recent window'>
	RecentlyClosedWindowsSaver default restoreWindow
]

{ #category : 'conveniance' }
PharoQuickAccess >> randomBackground [
	<name: #'Set random background'>

	PharoCommonSettings setRandomBackground
]

{ #category : 'conveniance' }
PharoQuickAccess >> refreshMenubar [
	<name: #'Refresh menubar'>
	self class resetMenubar
]

{ #category : 'counter' }
PharoQuickAccess >> resetCounter [
	counter := 0
]

{ #category : 'conveniance' }
PharoQuickAccess >> screenshot [
	<name: #Screenshot>
	Form fromUser asMorph openInWindow
]

{ #category : 'conveniance' }
PharoQuickAccess >> toggleDeprecation [
	<name: #'Togglee deprecations'>
	Deprecation raiseWarning: Deprecation raiseWarning not
]

{ #category : 'conveniance' }
PharoQuickAccess >> toggleTheme [
	<name: #'Toggle theme'>
	| light dark |
	dark := DarkBlueTheme.
	light := PharoLightTheme.

	(dark isCurrent
		ifTrue: [ light ]
		ifFalse: [ dark ]) beCurrent.

	PharoCommonSettings setThemeSetting
]

{ #category : 'conveniance' }
PharoQuickAccess >> toggleTodoBlocking [

	<name: 'Toggle todo blocking'>
	isTodoEnabled := isTodoEnabled not
]

{ #category : 'conveniance' }
PharoQuickAccess >> tweakGCParameters [
	<name: 'Tweak GC parameters'>

	"Increase eden size. This will reduce the amount of scavenge and speed up algo creating a lot of new objects been discard fast."
	Smalltalk vm parameterAt: 45 put: 64 * 1024 * 1024.

	"Increase growth headroom. When the memory will need to grow, it will directly allocate more room."
	Smalltalk vm parameterAt: 25 put: 32 * 1024 * 1024.

	"Increase shrinking threashold to shrink the memory less often"
	Smalltalk vm parameterAt: 24 put: 64 * 1024 * 1024.

	"Change the full GC ratio to only GC when the heap grows by 70% instead of 33% before."
	Smalltalk vm parameterAt: 55 put: 0.7
]
