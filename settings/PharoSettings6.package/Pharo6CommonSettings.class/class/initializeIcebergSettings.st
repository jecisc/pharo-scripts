initialization
initializeIcebergSettings
	IceRepository
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation:
			((StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories')
				ensureCreateDirectory;
				yourself).
	IceCredentialsProvider useCustomSsh: true
