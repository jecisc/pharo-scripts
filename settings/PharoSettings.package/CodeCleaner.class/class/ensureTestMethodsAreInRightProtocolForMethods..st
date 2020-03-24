protocols
ensureTestMethodsAreInRightProtocolForMethods: methods
	| testCasesMethods |
	testCasesMethods := methods select: [ :method | method methodClass isTestCase and: [ method isExtension not ] ].
	self ensureMatching: [ :method | #(#setUp #tearDown) includes: method selector ] areIn: #running for: testCasesMethods.
	self ensureMatching: [ :method | (method selector beginsWith: 'test') and: [ (method protocol beginsWith: 'test') not ] ] areIn: #tests for: testCasesMethods