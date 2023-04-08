StartupPreferencesLoader default executeAtomicItems: {			

	StartupAction
		name: 'Load Settings'
		code: [ 
			SystemVersion current major > 6 ifTrue: [
				Metacello new
					filetreeDirectory: (StartupPreferencesLoader preferencesGeneralFolder / 'settings') fullName;
					baseline: 'PharoSettings';
					load 
			]
		]
		runOnce: true
}