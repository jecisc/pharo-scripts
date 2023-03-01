Class {
	#name : #Pharo6CommonSettings,
	#superclass : #PharoAbstractSettings,
	#category : 'PharoSettings6'
}

{ #category : #initialization }
Pharo6CommonSettings class >> collectAllSubprojectsFrom: aDirectory into: aCollection [
	(aDirectory directories anySatisfy: [ :e | e basename = '.git' ]) ifTrue: [ aCollection add: aDirectory ] ifFalse: [ aDirectory directories do: [ :dir | self collectAllSubprojectsFrom: dir into: aCollection ] ]
]

{ #category : #initialization }
Pharo6CommonSettings class >> customizeBlockStyler [
	<script>
	BlockStyler defaultThemes at: self darkThemeClass put: (Color lightBlue alpha: 0.05).
	BlockStyler defaultThemes at: self lightThemeClass put: (Color blue alpha: 0.05)
]

{ #category : #initialization }
Pharo6CommonSettings class >> initialize [
	self
		initializeIcebergSettings;
		initializePotentialIcebergRepos;
		customizeBlockStyler;
		registerBazard
]

{ #category : #initialization }
Pharo6CommonSettings class >> initializeIcebergSettings [
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
]

{ #category : #initialization }
Pharo6CommonSettings class >> initializePotentialIcebergRepos [
	<script>
	| projects |
	projects := OrderedCollection new.
	self collectAllSubprojectsFrom: self sharedRepositoryFolder into: projects.
	IceRepository registry do: [ :repo | projects detect: [ :e | e basename asLowercase = repo name asLowercase and: [ repo location isNil or: [ repo location exists not ] ] ] ifFound: [ :dir | repo location: dir ] ]
]

{ #category : #initialization }
Pharo6CommonSettings class >> registerBazard [
	<script>
	self registerIfPresentProjectOf: 'jecisc' named: 'Bazard'
]

{ #category : #'see class side' }
Pharo6CommonSettings >> seeClassSide [
]
