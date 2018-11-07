*PharoSettings
generatesPotentialSetterOrGetterWith: anArray
	<debuggerCompleteToSender>
	| message aMessage selectorsToIgnore |
	
	"In some cases I want to not generate the accessors."
	selectorsToIgnore := #(
	'buttonPresenter'	"This one is in a Spec Mock to test usage of the Interpreter when there is no getter. So I do not want to generate a getter for the test. Remove when I will not work on Spec anymore."
	).
	
	aMessage := anArray anyOne.
	message := aMessage selector asString.
	(selectorsToIgnore includes: message) ifTrue: [ ^ self ].
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