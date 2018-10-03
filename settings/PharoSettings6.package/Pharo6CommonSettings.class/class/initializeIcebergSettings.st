initialization
initializeIcebergSettings

	"Add a shared repository"
	self flag: #todo.	"Remove hack when the Pharo 6 version will always have at least Iceberg v0.7"
	((IceRepository respondsTo: #shareRepositoriesBetweenImages:) ifTrue: [ IceRepository ] ifFalse: [ IceLibgitRepository ])
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation:
			(self sharedRepositoryFolder
				ensureCreateDirectory;
				yourself).

	"Use wy SSH key"
	IceCredentialsProvider useCustomSsh: true.

	"Make sur Metacello integration is on, even in Pharo 6"
	Iceberg enableMetacelloIntegration: true.

	"Add my preference folder by default"
	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder;
		subdirectory: 'settings';
		createRepository) register