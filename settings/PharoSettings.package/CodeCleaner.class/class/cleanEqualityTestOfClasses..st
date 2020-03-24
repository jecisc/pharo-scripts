equality
cleanEqualityTestOfClasses: aCollection
	self cleanEqualityTestOfTestCases: (aCollection select: #isTestCase)