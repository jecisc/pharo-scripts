initialization
initializeIcebergSettings
	"Add a shared repository"
	IceRepository
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation:
			((StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories')
				ensureCreateDirectory;
				yourself).
	
	"Use wy SSH key"
	IceCredentialsProvider useCustomSsh: true.
	
	"Make sur Metacello integration is on, even in Pharo 6"
	Iceberg enableMetacelloIntegration: true.
	
	"Show Pharo repository because I contribute a lot"
	Iceberg showSystemRepositories: true.
	IceRepository registry detect: [ :each | each name = 'pharo' ] ifFound: [ :each | each location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo' ].
	
	"Add my preference folder by default"
	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder;
		subdirectory: 'settings';
		createRepository) register