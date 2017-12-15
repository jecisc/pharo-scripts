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
	
	"Add Pharo by default"
	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo';
		subdirectory: 'src';
		createRepository) register.
	
	"Add my preference folder by default"
	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder;
		subdirectory: 'settings';
		createRepository) register