Extension { #name : 'Package' }

{ #category : '*PharoSettings' }
Package >> numberOfLinesOfCode [
	^ (self definedClasses ifEmpty: [ 0 ] ifNotEmpty: [ :cs | cs sum: #linesOfCode ]) + (self extensionMethods sum: #linesOfCode)
]
