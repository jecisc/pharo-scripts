StartupPreferencesLoader default executeAtomicItems: {			
	StartupAction
		name: 'Insecable space rule'
		code: [
		ReAbstractRule subclass: #ReInsecableSpaceRule
	slots: {  }
	classVariables: {  }
	category: '_UnpackagedPackage'.
				
			ReInsecableSpaceRule compile: 'basicCheck: aMethod
	^ aMethod sourceCode includes: Character nbsp'  classified: 'running'.
				
			ReInsecableSpaceRule compile: 'group
	^ ''Bugs''' classified: 'accessing'.
				
			ReInsecableSpaceRule compile: 'name
	^ ''There is an insequable space that might break the method.''' classified: 'accessing'.
				
			ReInsecableSpaceRule compile: 'rationale
	^ ''Insecable spaces might break a lot of code and is usually unitentional.''' classified: 'accessing'.
				
			ReInsecableSpaceRule compile: 'severity
	^ #error' classified: 'accessing'.
				
			ReInsecableSpaceRule class compile: 'checksMethod
	^ true' classified: 'testing-interest'.
	
	ReRuleManager resetWithInform.
		]
		runOnce: true.
	
}