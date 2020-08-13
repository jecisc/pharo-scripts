accessing
subDirectoriesOf: aDirectory
	^ directoriesMap at: aDirectory ifAbsentPut: [ aDirectory directories ]