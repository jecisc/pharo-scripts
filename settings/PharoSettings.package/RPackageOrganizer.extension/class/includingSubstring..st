*PharoSettings
includingSubstring: aString
	^ self default packages select: [ :p | p name includesSubstring: aString ]