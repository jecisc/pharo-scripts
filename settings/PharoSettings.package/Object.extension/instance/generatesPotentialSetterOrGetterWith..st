*PharoSettings
generatesPotentialSetterOrGetterWith: anArray
	<debuggerCompleteToSender>
	| message aMessage |
	aMessage := anArray anyOne.
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
					^ aMessage sentTo: self ] ]