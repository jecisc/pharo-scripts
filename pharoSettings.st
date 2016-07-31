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
		name: 'AdaptTheme'
		code: [ 
				| installThemeBlock currentTheme |

				installThemeBlock := [ | theme |
					theme := (Time now between: '7:00am' asTime and: '9:00pm' asTime) ifTrue: [ Pharo3DarkTheme ] ifFalse: [ Pharo3Theme ].
					theme = currentTheme ifFalse: [ currentTheme := theme. PolymorphSystemSettings uiThemeClass: currentTheme ] ].

					[ [ installThemeBlock value. 5 minutes asDelay wait ] repeat ] 
						newProcess priority: Processor systemBackgroundPriority; 
						name: 'changeTheme'; 
						resume 
			]
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
		
	StartupAction
		name: 'Remove Pharo Repositories to avoid to lose time with Monticello'
		code: [ MCRepositoryGroup default repositories select: [ :r | r location includesSubstring: 'Pharo/Pharo' ] thenDo: [ :r | MCRepositoryGroup default removeRepository: r ] ]
		runOnce: true.
		
	StartupAction
		name: 'Generate Accessor automatically'
		code: [ Object compile: 'doesNotUnderstand: aMessage
	| exception resumeValue message |
	message := aMessage selector asString.
	message last = $:
		ifTrue: [ self class instVarNames
				detect: [ :var | var = message allButLast ]
				ifFound: [ :var | 
					self class
						compile:
							(String
								streamContents: [ :s | 
									s
										<< message;
										<< '' anObject'';
										<< String cr;
										<< Character tab;
										<< var;
										<< '' := anObject'' ])
						classified: ''accessing''.
					UIManager default inform: ''Compiled: '' , message , '' into: '' , self printString.
					^ aMessage sentTo: self ] ]
		ifFalse: [ self class instVarNames
				detect: [ :var | var = message ]
				ifFound: [ :var | 
					self class
						compile:
							(String
								streamContents: [ :s | 
									s
										<< var;
										cr;
										<< Character tab;
										<< ''^ '';
										<< var ])
						classified: ''accessing''.
					UIManager default inform: ''Compiled: '' , message , '' into: '' , self printString.
					^ aMessage sentTo: self ] ].
	(exception := MessageNotUnderstood new)
		message: aMessage;
		receiver: self.
	resumeValue := exception signal.
	^ exception reachedDefaultHandler
		ifTrue: [ aMessage sentTo: self ]
		ifFalse: [ resumeValue ]' ]
		runOnce: true.
		
	StartupAction
		name: 'Set the default github-cache'
		code: [ 
			MCGitHubRepository cacheDirectory:
				(((OSPlatform current isWindows
					ifTrue: [ FileLocator C "This is a hack to shorten windows's paths because windows have a max path of 255 characters :(" ]
					ifFalse: [ StartupPreferencesLoader preferencesGeneralFolder ]) / 'github-cache')
					ensureCreateDirectory;
					yourself)
		]
		runOnce: true.
		
}
