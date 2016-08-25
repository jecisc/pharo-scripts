StartupPreferencesLoader default executeAtomicItems: {			
	StartupAction
		name: 'Insecable space rule'
		code: [
		ReBasicMethodRule subclass: #ReInsecableSpaceRule
	slots: {  }
	classVariables: {  }
	category: '_UnpackagedPackage'.
				
			#ReInsecableSpaceRule asClass compile: 'basicCheck: aMethod
	^ aMethod sourceCode includes: Character nbsp'  classified: 'running'.
				
			#ReInsecableSpaceRule asClass compile: 'group
	^ ''Bugs''' classified: 'accessing'.
				
			#ReInsecableSpaceRule asClass compile: 'name
	^ ''There is an insequable space that might break the method.''' classified: 'accessing'.
				
			#ReInsecableSpaceRule asClass compile: 'rationale
	^ ''Insecable spaces might break a lot of code and is usually unitentional.''' classified: 'accessing'.
				
			#ReInsecableSpaceRule asClass compile: 'severity
	^ #error' classified: 'accessing'.
				
			#ReInsecableSpaceRule asClass compile: 'anchorFor: anEntity
	^ ReSearchStringSourceAnchor entity: anEntity string: Character nbsp asString' classified: 'helpers'.
	
	ReRuleManager resetWithInform.
		]
		runOnce: true.
	
}
