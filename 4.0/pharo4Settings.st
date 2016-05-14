StartupPreferencesLoader default executeAtomicItems: {			
	StartupAction
		name: 'Idea icons'
		code: [
			Gofer it directory: ((StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'ProjectCache' / 'IdeaIcons') fullName); package: 'Polymorph-Icons-Idea';load.
			ThemeIcons current: #IdeaUIThemeIcons asClass new.
			AbstractNautilusUI resetIconCaches
		]
		runOnce: true
	
}