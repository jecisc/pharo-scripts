protocols
ensureTestMethodsAreInRightProtocol
	(self definedTestCases flatCollect: #localMethods)
		select: [ :method | method isExtension not and: [ (method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ] ] ]
		thenDo: [ :method1 | method1 protocol = #tests ifFalse: [ method1 protocol: #tests ] ]