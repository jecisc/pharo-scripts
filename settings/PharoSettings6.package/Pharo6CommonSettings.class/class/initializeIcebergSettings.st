initialization
initializeIcebergSettings
	IceRepository
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation:
			((StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories')
				ensureCreateDirectory;
				yourself).
	OSPlatform current isWindows
		ifTrue: [ IceCredentialsProvider useCustomSsh: true ]
