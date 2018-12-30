initialization
darkThemeClass
	^ SystemVersion current major >= 7
		ifTrue: [ GreenTheme ]
		ifFalse: [ Pharo3DarkTheme ]