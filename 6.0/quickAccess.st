StartupPreferencesLoader default executeAtomicItems: {
	StartupAction
		name: 'Install & populate QuickAccess'
		code: [
			Metacello new
				configuration: 'QuickAccess';
				repository:  (StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'ProjectCache' / 'QuickAccess' ) fullName;
				load: #( #Tools ).
		]
		runOnce: true.

	StartupAction
		name: 'Reload QuickAccess config'
		code: [
			(Smalltalk hasClassNamed: #QACActionManager) ifTrue: [
				#QACActionManager asClass default
					import:  (StartupPreferencesLoader preferencesGeneralFolder / 'SettingRessources' / 'quickAccess.qac').
			]
		]
		runOnce: false.	
}