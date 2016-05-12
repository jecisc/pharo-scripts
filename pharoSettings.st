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

}