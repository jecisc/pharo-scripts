equality
cleanEqualityTestOfPackages: aCollection
	self cleanEqualityTestOfClasses: (aCollection flatCollect: #definedClasses)