protocols
ensureTestMethodsAreInRightProtocolForMethods: methods
	methods
		select: [ :method | method methodClass isTestCase ]
		thenDo: [ :method | 
			(#(#setUp #tearDown) includes: method selector) ifTrue: [ method protocol: 'running' ].
			((method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ]) ifTrue: [ method protocol: 'tests' ] ]