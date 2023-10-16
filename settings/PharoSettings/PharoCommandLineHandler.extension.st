Extension { #name : 'PharoCommandLineHandler' }

{ #category : '*PharoSettings' }
PharoCommandLineHandler >> handleArgument: aString [
	aString = '--sfw' ifTrue: [ ^ self ].

	super handleArgument: aString
]
