helpers
sharedRepositoryFolder
	| file |
	file := self resourcesFolder / 'localisation'.
	file exists
		ifFalse: [ | cred |
			cred := Dictionary new.
			cred at: #dir put: (UIManager default textEntry: 'Path to Iceberg default folder').
			file writeStreamDo: [ :s | s nextPutAll: (STON toStringPretty: cred) ] ].
	^ ((STON fromString: file contents) at: #dir) asFileReference