*PharoSettings
handleArgument: aString
	aString = '--sfw' ifTrue: [ ^ self ].

	super handleArgument: aString