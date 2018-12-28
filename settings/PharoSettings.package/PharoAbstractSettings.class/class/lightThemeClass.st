initialization
lightThemeClass
	^ SystemVersion current major >= 7
		ifTrue: [ PharoLightTheme ]
		ifFalse: [ Pharo3Theme ]