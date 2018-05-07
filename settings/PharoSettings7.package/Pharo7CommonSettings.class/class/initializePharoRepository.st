initialization
initializePharoRepository
	"Add Pharo by default"

	self flag: #clean.	"When Iceberg will be more stable, update this."
	IceRepository registry
		detect: [ :repo | repo name = 'pharo' and: [ repo location isNil ] ]
		ifFound: [ :repo | 
			repo
				location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo';
				subdirectory: 'src' ]
		ifNone: [ (IceRepositoryCreator new
				location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo';
				subdirectory: 'src';
				createRepository) register ]