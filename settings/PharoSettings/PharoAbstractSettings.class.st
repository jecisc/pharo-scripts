Class {
	#name : #PharoAbstractSettings,
	#superclass : #Object,
	#category : #PharoSettings
}

{ #category : #initialization }
PharoAbstractSettings class >> backgroundFolder [
	^ self resourcesFolder / 'backgrounds'
]

{ #category : #helpers }
PharoAbstractSettings class >> projectCache [
	^ self resourcesFolder / 'ProjectCache'
]

{ #category : #initialization }
PharoAbstractSettings class >> registerIfPresentProjectAt: location subdirectory: subdirectory [
	location exists ifFalse: [ ^ self ].

	[ (IceRepositoryCreator new
		location: location;
		subdirectory: subdirectory;
		createRepository) register ]
		on: IceDuplicatedRepository
		do: [ "nothing" ]
]

{ #category : #initialization }
PharoAbstractSettings class >> registerIfPresentProjectOf: owner named: project [
	self registerIfPresentProjectOf: owner named: project subdirectory: 'src'
]

{ #category : #initialization }
PharoAbstractSettings class >> registerIfPresentProjectOf: owner named: project subdirectory: subdirectory [
	self registerIfPresentProjectAt: StartupPreferencesLoader preferencesGeneralFolder / 'GitRepositories' / owner / project subdirectory: subdirectory
]

{ #category : #helpers }
PharoAbstractSettings class >> resourcesFolder [
	^ self rootFolder / 'SettingRessources'
]

{ #category : #helpers }
PharoAbstractSettings class >> rootFolder [
	^ StartupPreferencesLoader preferencesGeneralFolder
]

{ #category : #helpers }
PharoAbstractSettings class >> sharedRepositoryFolder [
	| file |
	file := self resourcesFolder / 'localisation'.
	file exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #dir put: (UIManager default textEntry: 'Path to Iceberg default folder').
			file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	^ ((STON fromString: file contents) at: #dir) asFileReference
]

{ #category : #asserting }
PharoAbstractSettings class >> shouldBeSFW [
	^ CommandLineArguments default hasOption: 'sfw'
]
