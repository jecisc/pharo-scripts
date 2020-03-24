protocols
ensureTestMethodsAreInRightProtocolForMethods: methods
	methods
		select:
			[ :method | method methodClass isTestCase and: [ method isExtension not and: [ (method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ] ] ] ]
		thenDo: [ :method1 | method1 protocol = #tests ifFalse: [ method1 protocol: #tests ] ]