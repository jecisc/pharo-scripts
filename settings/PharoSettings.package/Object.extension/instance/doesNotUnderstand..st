*PharoSettings
doesNotUnderstand: aMessage
	| exception resumeValue message |
	message := aMessage selector asString.
	message last = $:
		ifTrue: [ self class instVarNames
				detect: [ :var | var = message allButLast ]
				ifFound: [ :var | 
					self compileSetterNamed: message returning: var.
					^ aMessage sentTo: self ] ]
		ifFalse: [ self class instVarNames
				detect: [ :var | var = message ]
				ifFound: [ :var | 
					self compileGetterNamed: var.
					^ aMessage sentTo: self ] ].
	(exception := MessageNotUnderstood new)
		message: aMessage;
		receiver: self.
	resumeValue := exception signal.
	^ exception reachedDefaultHandler
		ifTrue: [ aMessage sentTo: self ]
		ifFalse: [ resumeValue ]