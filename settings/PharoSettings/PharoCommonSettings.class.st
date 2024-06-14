"
Settings to load in all supported Pharo versions.
"
Class {
	#name : 'PharoCommonSettings',
	#superclass : 'PharoAbstractSettings',
	#category : 'PharoSettings',
	#package : 'PharoSettings'
}

{ #category : 'class initialization' }
PharoCommonSettings class >> addIcebergHack [
	"Add a hack to fetch a project if a commit is not found."

	<script>
	(IceGitCommit >> #project) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #projectAlt;
				control: #instead).

	"In the «New branch from issue» panel of Iceberg, select origin as remote all the time and not mine or another remote.
	In P9 the method was renamed."
	(IceGitHubNewBranchFromIssuePanel
		>>
			(SystemVersion current major < 9
				ifTrue: [ #initializeWidgetsContents ]
				ifFalse: [ #initializePresenters ])) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #selectOrigin;
				control: #after)
]

{ #category : 'class initialization' }
PharoCommonSettings class >> addMetaLinkForDNUTrick [
	<script>
	(Object >> #doesNotUnderstand:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #generatesPotentialSetterOrGetterWith:context:;
				arguments: #(#arguments #context);
				control: #before)
]

{ #category : 'class initialization' }
PharoCommonSettings class >> closeWelcomeWindow [
	<script>
	World submorphs select: [ :m | m isSystemWindow and: [ m label includesSubstring: 'Welcome' ] ] thenDo: #delete
]

{ #category : 'class initialization' }
PharoCommonSettings class >> collectAllSubprojectsFrom: aDirectory into: aCollection [
	(aDirectory directories anySatisfy: [ :e | e basename = '.git' ]) ifTrue: [ aCollection add: aDirectory ] ifFalse: [ aDirectory directories do: [ :dir | self collectAllSubprojectsFrom: dir into: aCollection ] ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> copyClassShouldCopyComment [
	"Because the community does not want it, but I want it. http://forum.world.st/Bad-copied-class-comment-td5106493.html"
	<script>
	(Class >> #duplicateClassWithNewName:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #altDuplicateClassWithNewName:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : 'class initialization' }
PharoCommonSettings class >> customizeBlockStyler [

	<script>
	BlockStyler defaultThemes
		at: PharoLightTheme
		put: (Color blue alpha: 0.05)
]

{ #category : 'class initialization' }
PharoCommonSettings class >> disableSampleInstance [
	<script>
	(ClySampleInstanceScript >> #executeOn:) ast
		link:
			(MetaLink new
				metaObject: #receiver;
				selector: #executeOnAlt:;
				arguments: #(#arguments);
				control: #instead)
]

{ #category : 'class initialization' }
PharoCommonSettings class >> enableStackColoring [
	<script>
	SystemVersion current major < 9 ifTrue: [ Smalltalk tools debugger enableStackColoring: true. ] ifFalse: [ self inform: 'Stack coloring is not yet in the debugger. Ask for it later.' ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> initialize [
	self
		setAuthorName;
		setAppearance;
		showBoundsInHalo;
		removeTaskBarPreview;
		setThemeSetting;
		addMetaLinkForDNUTrick;
		updateCurrentCursor;
		copyClassShouldCopyComment;
		shortcutReminderSettings;
		enableStackColoring;
		closeWelcomeWindow;
		monticelloOptions;
		initializeIcebergSettings;
		initializePotentialIcebergRepos;
		addIcebergHack;
		customizeBlockStyler;
		registerBazard;
		disableSampleInstance;
		removeSomeRules;
		resetMenuBar
]

{ #category : 'class initialization' }
PharoCommonSettings class >> initializeIcebergSettings [
	"Add a shared repository"

	<script>
	| file creds |
	self flag: #todo. "Remove hack when the Pharo 6 version will always have at least Iceberg v0.7"
	((IceRepository respondsTo: #shareRepositoriesBetweenImages:)
		 ifTrue: [ IceRepository ]
		 ifFalse: [ IceLibgitRepository ])
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation: (self sharedRepositoryFolder
				 ensureCreateDirectory;
				 yourself).

	"Use wy SSH key"
	IceCredentialsProvider useCustomSsh: true.

	(FileLocator home / '.ssh' / 'id_ed25519') exists ifTrue: [
		IceCredentialStore current defaultSSHCredential
			publicKey: '/Users/cyril/.ssh/id_ed25519.pub';
			privateKey: '/Users/cyril/.ssh/id_ed25519' ].

	"Make sur Metacello integration is on, even in Pharo 6"
	Iceberg enableMetacelloIntegration: true.

	"Add my preference folder by default"
	(IceRepositoryCreator new
		 location: StartupPreferencesLoader preferencesGeneralFolder;
		 subdirectory: 'settings';
		 createRepository) register.
		
	file := self resourcesFolder / 'CredsIceberg'.
	file exists ifFalse: [
		file writeStreamDo: [ :s |
			s nextPutAll: (STON toStringPretty:
					 (Dictionary with: #username -> (UIManager default textEntry: 'Username') with: #password -> (UIManager default requestPassword: 'Password'))) ] ].
	creds := STON fromString: file contents.

	IceCredentialStore current
		storeCredential: (IcePlaintextCredentials new
				 username: (creds at: #username);
				 password: (creds at: #password);
				 yourself)
		forHostname: 'github.com'.

	"Open Iceberg. I often need it."
	SystemVersion current major < 10
		ifTrue: [ IceTipRepositoriesBrowser new openWithSpec ]
		ifFalse: [ IceTipRepositoriesBrowser new open ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> initializePotentialIcebergRepos [
	<script>
	| projects |
	projects := OrderedCollection new.
	self collectAllSubprojectsFrom: self sharedRepositoryFolder into: projects.
	IceRepository registry do: [ :repo | projects detect: [ :e | e basename asLowercase = repo name asLowercase and: [ repo location isNil or: [ repo location exists not ] ] ] ifFound: [ :dir | repo location: dir ] ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> installGitFileTree [
	<script>
	Metacello new
		baseline: 'FileTree';
		repository: 'github://dalehenrich/filetree:pharo' , SystemVersion current dottedMajorMinor , '_dev/repository';
		load: 'Git'
]

{ #category : 'class initialization' }
PharoCommonSettings class >> monticelloOptions [

	<script>
	| creds file |
	file := self resourcesFolder / 'Creds'.
	file exists ifFalse: [
		| cred |
		cred := Dictionary new.
		cred at: #username put: (UIManager default textEntry: 'Username').
		cred at: #password put: (UIManager default requestPassword: 'Password').
		file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	creds := STON fromString: file contents.
	MCRepositoryGroup default repositories do: [ :rep |
		[
		rep user: (creds at: #username).
		rep password: (creds at: #password) ]
			on: Error
			do: [  ] ].
	MCCacheRepository cacheDirectory: ((self rootFolder / 'package-cache')
			 ensureCreateDirectory;
			 yourself).
	MCGitHubRepository cacheDirectory: (((OSPlatform current isWindows
			   ifTrue: [ FileLocator C "This is a hack to shorten windows's paths because windows have a max path of 255 characters :(" ]
			   ifFalse: [ self rootFolder ]) / 'github-cache')
			 ensureCreateDirectory;
			 yourself).
	MCRepositoryGroup default repositories
		select: [ :r | (r isKindOf: MCSmalltalkhubRepository) and: [ r location includesSubstring: 'Pharo/Pharo' ] ]
		thenDo: [ :r | MCRepositoryGroup default removeRepository: r ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> registerBazard [
	<script>
	self registerIfPresentProjectOf: 'jecisc' named: 'Bazard'
]

{ #category : 'class initialization' }
PharoCommonSettings class >> removeLogo [
	<script>
	PolymorphSystemSettings showDesktopLogo: false
]

{ #category : 'removing' }
PharoCommonSettings class >> removeSomeRules [
	<script>
	self flag: #todo. "Add a way to disable those if they are loaded *after* startup. Maybe register to the class added announcement?"
	#(#GRNonPortableSourceFormatRule #GRTestAssertionsRule #GRUsesCurlyBraceArraysRule #GRAnsiStreamsRule #GRAnsiExceptionsRule #GREmptyStatementsRule #GRInvalidObjectInitializationRule #GRUsesLiteralByteArraysRule #GRAnsiStringsRule #GRAnsiConvertorRule #GRObjectInRule #GRNonPortableMessageRule #GRAnsiConditionalsRule #GRAnsiBooleansRule #GRBasicNewInitializeMissingRule #GRAnsiCollectionsRule #GRUsesClassForHashRule #GRUsesCanPerformOrUnderstandRule #GRUsesNotPortableClassRule #GRNotPortableCollectionsRule #GRUsesMethodAnnotationsRule #GRAnsiCharactersRule)
		do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	#(#RBShouldntRaiseErrorRule #ReShouldntRaiseErrorRule #ReCollectionMessagesToExternalObjectRule) do: [ :each | self environment at: each ifPresent: [ :class | class enabled: false ] ].

	ReRuleManager reset
]

{ #category : 'class initialization' }
PharoCommonSettings class >> removeTaskBarPreview [
	<script>
	TaskbarMorph showWindowPreview: false
]

{ #category : 'class initialization' }
PharoCommonSettings class >> resetMenuBar [
	<script>
	"Needed to make scripts work."

	PharoQuickAccess resetMenubar
]

{ #category : 'class initialization' }
PharoCommonSettings class >> setAppearance [
	<script>
	self removeLogo.
	self setRandomBackground.
	self setFonts
]

{ #category : 'class initialization' }
PharoCommonSettings class >> setAuthorName [
	<script>
	Author fullName: 'CyrilFerlicot'
]

{ #category : 'class initialization' }
PharoCommonSettings class >> setFonts [
	<script>
	| provider |
	provider := FreeTypeFontProvider current.

	((provider platformAbsoluteDirectories flatCollect: #files) select: [ :e | e basename beginsWith: 'Noto' ])
		ifEmpty: [ self inform: 'Font is not installed' ]
		ifNotEmpty: [ :fonts |
			fonts do: [ :file | provider updateFromFile: file ].
			provider updateAvailableFontFamilies.
			StandardFonts defaultFont: (LogicalFont familyName: 'Noto Sans' pointSize: 10).
			GraphicFontSettings resetAllFontToDefault ]
]

{ #category : 'class initialization' }
PharoCommonSettings class >> setRandomBackground [

	<script>
	[
	| files |
	files := self backgroundFolder allFiles.
	files := files reject: [ :f | f basename beginsWith: '.' ].
	PolymorphSystemSettings desktopImageFileName: (files at: UUID new asInteger \\ files size + 1) fullName ] fork
]

{ #category : 'class initialization' }
PharoCommonSettings class >> setThemeSetting [
	<script>
	UITheme currentSettings fastDragging: true
]

{ #category : 'class initialization' }
PharoCommonSettings class >> shortcutReminderSettings [
	<script>
	ShortcutReminder defaultReminder limit: -1.
	ShortcutReminder defaultReminder position: #topRight
]

{ #category : 'class initialization' }
PharoCommonSettings class >> showBoundsInHalo [
	<script>
	HaloMorph showBoundsInHalo: true
]

{ #category : 'class initialization' }
PharoCommonSettings class >> updateCurrentCursor [
	<script>
	PawCursor beCurrent
]

{ #category : 'see class side' }
PharoCommonSettings >> seeClassSide [
]
