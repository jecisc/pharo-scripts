StartupPreferencesLoader default executeAtomicItems: {			
	StartupAction
		name: 'Idea icons'
		code: [
			Gofer it directory: ((StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'ProjectCache' / 'IdeaIcons') fullName); package: 'Polymorph-Icons-Idea';load.
			ThemeIcons current: #IdeaUIThemeIcons asClass new.
			AbstractNautilusUI resetIconCaches
		]
		runOnce: true.
	
	StartupAction
		name: 'Install ston if needed'
		code: [
			(Smalltalk globals includesKey: #STON) ifFalse: [
				Metacello new
					configuration: 'Ston';
					repository:  (StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'ProjectCache' / 'STON' / 'Pharo4' ) fullName;
					load
			]
		]
		runOnce: true.
	
}