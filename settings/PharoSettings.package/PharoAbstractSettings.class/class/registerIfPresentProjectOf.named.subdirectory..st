initialization
registerIfPresentProjectOf: owner named: project subdirectory: subdirectory
	self registerIfPresentProjectAt: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / owner / project subdirectory: subdirectory