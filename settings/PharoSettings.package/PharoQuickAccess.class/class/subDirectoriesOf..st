accessing
subDirectoriesOf: aDirectory
	directoriesMap ifNil: [ directoriesMap := Dictionary new ].
	^ directoriesMap at: aDirectory ifAbsentPut: [ aDirectory directories ]