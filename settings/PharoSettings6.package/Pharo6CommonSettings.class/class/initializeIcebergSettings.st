initialization
initializeIcebergSettings
	IceRepository
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation:
			((StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories')
				ensureCreateDirectory;
				yourself).
	IceCredentialsProvider useCustomSsh: true.
	Iceberg showSystemRepositories: true.
	IceRepository registry detect: [ :each | each name = 'pharo' ] ifFound: [ :each | each location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo' ]