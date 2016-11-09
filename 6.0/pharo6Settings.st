StartupPreferencesLoader default executeAtomicItems: {			

	StartupAction
		name: 'Load Settings'
		code: [ Metacello new
			filetreeDirectory: (StartupPreferencesLoader preferencesGeneralFolder / 'settings') fullName;
			baseline: 'PharoSettings';
			load 
		]
		runOnce: true
}