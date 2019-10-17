*PharoSettings
includingWith: aString
	^ self default packages select: [ :p | p name includesSubstring: aString ]