facade
cleanEqualityTestOfClasses: aCollection
	self cleanEqualityTestOfTestCases: (aCollection select: #isTestCase)