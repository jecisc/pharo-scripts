facade
cleanEqualityTestOfClasses: aCollection
	self cleanEqualityTestOfPackages: (aCollection select: #isTestCase)