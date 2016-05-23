StartupPreferencesLoader default executeAtomicItems: {
	StartupAction
		name: 'Set the Author'
		code: [ Author fullName: 'CyrilFerlicot' ]
		runOnce: true.

	StartupAction
		name: 'GTSpotter usage data'
		code: [ (Smalltalk globals includesKey: #GTSpotterEventRecorderSettings) ifTrue: [ #GTSpotterEventRecorderSettings asClass sendUsageData: true ] ]
		runOnce: true.

	StartupAction
		name: 'No logo'
		code: [	PolymorphSystemSettings showDesktopLogo: false ]
		runOnce: true.
			
	StartupAction
		name: 'Dark theme'
		code: [ PolymorphSystemSettings uiThemeClass: Pharo3DarkTheme ]
		runOnce: true.
		
	StartupAction 
		name: 'Fast dragging' 
		code: [ UITheme currentSettings fastDragging: true ]
		runOnce: true.
		
	StartupAction
		name: 'Exhibits bounds' 
		code: [ HaloMorph showBoundsInHalo: true ] 
		runOnce: true.
		
	StartupAction 
		name: 'Desktop background image file name' 
		code: [ | files |
			files := (StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'backgrounds') allFiles.
			PolymorphSystemSettings desktopImageFileName: (files at: (UUIDGenerator default makeSeed \\ files size) + 1) fullName. ] 
		runOnce: false.
		
	StartupAction 
		name: 'Class Template with Slots' 
		code: [ Slot showSlotClassDefinition: true ]
		runOnce: true.
		
	StartupAction 
		name: 'Close welcolm window' 
		code: [ (SystemWindow allInstances select:  [ :w | w labelString includesSubstring: 'Welcome' ]) do: #delete ]
		runOnce: true.
		
	StartupAction
		name: 'Local Playground cache directory'
		code: [ GTPlayBook cacheDirectory: (StartupPreferencesLoader preferencesGeneralFolder / 'play-cache') ]
		runOnce: true.
		
	StartupAction
		name: 'Local Playground stash directory'
		code: [ GTPlayBook stashDirectory: (StartupPreferencesLoader preferencesGeneralFolder / 'play-stash' ) ]
		runOnce: true.
		
	StartupAction 
		name: 'Local cache directory' 
		code: [ MCCacheRepository cacheDirectory:  (StartupPreferencesLoader preferencesGeneralFolder / 'package-cache' ) ]
		runOnce: true.
		
	StartupAction
		name: 'Set Monticello infos'
		code: [ (Smalltalk globals includesKey: #STON)
			ifTrue: [ | creds file |
				file := StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'Creds'.
				file exists ifFalse: [ | cred | cred := Dictionary new.	cred at: #username put: (UIManager default textEntry: 'Username'). cred at: #password put: (UIManager default requestPassword: 'Password').	file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
				creds := STON fromString: file contents.
				MCRepositoryGroup default repositories do: [ :rep | [ rep user: (creds at: #username). rep password: (creds at: #password) ] on: Error do: [  ] ] ]
		]
		runOnce: true.
		
	StartupAction
		name: 'Set only dirty in MC'
		code: [ MCWorkingCopyBrowser order: 4 ]
		runOnce: true.
		
}
