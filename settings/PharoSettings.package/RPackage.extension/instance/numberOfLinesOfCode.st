*PharoSettings
numberOfLinesOfCode
	^ (self definedClasses sum: #linesOfCode) + (self extensionMethods detectSum: #linesOfCode)