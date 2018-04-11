initialization
initializePharoRepository
	"Add Pharo by default"

	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo';
		subdirectory: 'src';
		createRepository) register