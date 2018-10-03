initialization
installSpecRepository
	<script>
	(Smalltalk shortImageName beginsWith: 'Spec-') ifFalse: [ ^ self ].
	
	(IceRepositoryCreator new
		location: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / 'pharo-spec' / 'Spec';
		subdirectory: 'src';
		createRepository) register