*PharoSettings
numberOfLinesOfCode
	^ (self definedClasses sum: #numberOfLinesOfCode) + (self extensionMethods detectSum: #numberOfLinesOfCode)