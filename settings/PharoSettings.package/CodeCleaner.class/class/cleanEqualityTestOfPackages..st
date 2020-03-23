facade
cleanEqualityTestOfPackages: aCollection
	self cleanEqualityTestOfClasses: (aCollection flatCollect: #definedClasses)