initialization
imageNameBeginsWithAny: aCollection
	^ aCollection anySatisfy: [ :each | Smalltalk shortImageName beginsWith: each ]