initialization
initializeIcebergSettings
	"Add a shared repository"

	<script>
	self flag: #todo. "Remove hack when the Pharo 6 version will always have at least Iceberg v0.7"
	((IceRepository respondsTo: #shareRepositoriesBetweenImages:)
		 ifTrue: [ IceRepository ]
		 ifFalse: [ IceLibgitRepository ])
		shareRepositoriesBetweenImages: true;
		sharedRepositoriesLocation: (self sharedRepositoryFolder
				 ensureCreateDirectory;
				 yourself).

	"Use wy SSH key"
	IceCredentialsProvider useCustomSsh: true.

	(FileLocator home / '.ssh' / 'id_rsa') exists ifFalse: [
		IceCredentialStore current defaultSSHCredential
			publicKey: '/Users/cyril/.ssh/id_ed25519.pub';
			privateKey: '/Users/cyril/.ssh/id_ed25519' ].

	"Make sur Metacello integration is on, even in Pharo 6"
	Iceberg enableMetacelloIntegration: true.

	"Add my preference folder by default"
	(IceRepositoryCreator new
		 location: StartupPreferencesLoader preferencesGeneralFolder;
		 subdirectory: 'settings';
		 createRepository) register