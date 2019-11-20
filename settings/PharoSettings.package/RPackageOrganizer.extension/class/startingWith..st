*PharoSettings
startingWith: aString
	^ self default packages select: [ :p | p name beginsWith: aString ]