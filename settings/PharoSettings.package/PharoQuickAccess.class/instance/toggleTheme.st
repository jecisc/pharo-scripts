conveniance
toggleTheme
	<name: #'Toggle theme'>

	| light dark |
	dark := PharoAbstractSettings darkThemeClass.
	light := PharoAbstractSettings lightThemeClass.

	(dark isCurrent ifTrue: [ light ] ifFalse: [ dark ]) beCurrent.

	PharoCommonSettings setThemeSetting