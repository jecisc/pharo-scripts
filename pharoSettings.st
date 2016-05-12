StartupPreferencesLoader default executeAtomicItems: {
	StartupAction
		name: 'Set the Author'
		code: [ Author fullName: 'CyrilFerlciot' ]
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
		code: [ PolymorphSystemSettings desktopImageFileName: ((StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'back2.jpg') fullName)] 
		runOnce: true.
		
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
		runOnce: true

}